<#
.DESCRIPTION
Uses ffmpeg to normalize an audio file to a specified true peak value in dBFS
#>
function ConvertTo-NormalizedAudioFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$false)][float]$TargetTruePeak = 0, # True peak in dBFS
        [Parameter(Mandatory=$false)][switch]$OverwriteInputFile
    )

    if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue))
    {
        Write-Error "ffmpeg not installed. Run the 'Install-FFmpeg' cmdlet to install it."
        return
    }
    
    if (-not (Test-Path -Path $Path))
    {
        Write-Error "File not found"
        return
    }

    if ($TargetTruePeak -gt 0)
    {
        Write-Error "TargetTruePeak must be equal to or less than 0"
        return
    }

    $File = Get-Item $Path
    if ($File.Extension -ne ".wav" -and $File.Extension -ne ".mp3")
    {
        Write-Error "The file type $($File.Extension) is not supported"
        return
    }

    # Get volume offset
    $AudioAnalysis = ffmpeg -i $Path -af loudnorm=print_format=json -f null - 2>&1 | Out-String
    $Pattern = '"input_tp" : "(-?\d+\.\d+)"'
    $Match = $AudioAnalysis | Select-String -Pattern $Pattern
    $TruePeak = $Match.Matches.Groups[1].Value # Values greater than 0 are clipping
    
    $VolumeOffset = -$TruePeak + $TargetTruePeak # $TargetTruePeak will be less than or equal to 0
    $VolumeOffsetString
    if ($VolumeOffset -ge 0)
    {
        $VolumeOffsetString = "volume=+$($VolumeOffset)dB"
    }
    else
    {
        $VolumeOffset = -$VolumeOffset
        $VolumeOffsetString = "volume=-$($VolumeOffset)dB"
    }

    # Get bit rate
    $AudioCodec # For wav files (bit rate can be implied by the bit depth and the codec will change depending on the bit depth)
    $BitRate # For mp3 files
    switch ($File.Extension)
    {
        ".wav"
        {
            $BitDepth = & ffprobe -v error -select_streams a:0 -show_entries stream=bits_per_raw_sample -of default=noprint_wrappers=1:nokey=1 $Path
            $AudioCodec = switch ($BitDepth)
            {
                "16" { "pcm_s16le" }
                "24" { "pcm_s24le" }
                "32" { "pcm_s32le" }
                Default
                {
                    Write-Error "Unsupported bit depth"
                    return
                }
            }
        }
        ".mp3"
        {
            $BitRate = & ffprobe -v error -show_entries format=bit_rate -of default=noprint_wrappers=1:nokey=1 $Path
            $BitRate = [Math]::Round([int]$BitRate / 1000) # convert from bps to kbps
            $BitRate = "$($BitRate)k" # convert to string for ffmpeg
            Write-Output "Bit Rate: $BitRate"
        }
        default
        {
            Write-Error "Error: This script does not have a method of acquiring the bit depth / bit rate for $($File.Extension) files. Update this PowerShell cmdlet to support this behavior."
            return
        }
    }

    # Get output path
    $OutputPath
    if ($OverwriteInputFile)
    {
        $Guid = New-Guid
        $OutputPath = "$($File.DirectoryName)\$($Guid.Guid)$($File.Extension)"
    }
    else
    {
        $Counter = 1
        $CounterCutoff = 100
        do
        {
            $OutputPath = "$($File.DirectoryName)\$($File.BaseName)_Normalized_$Counter$($File.Extension)"
            if (-not (Test-Path -Path $OutputPath))
            {
                break
            }
    
            Write-Output "$OutputPath exists, incrementing counter"
            $Counter++
        } while ($Counter -lt $CounterCutoff)
    
        if ($Counter -ge $CounterCutoff)
        {
            Write-Error "All output file names are unavailable: ending process"
            return
        }
    }
    
    # Print info
    Write-Output "Input Path: $Path"
    Write-Output "Volume Offset: $VolumeOffset"
    if ($OverwriteInputFile)
    {
        Write-Output "Output Path: $Path"
    }
    else
    {
        Write-Output "Output Path: $OutputPath"
    }

    # Create the normalized file
    switch ($File.Extension)
    {
        ".wav"
        {
            & ffmpeg -y -i $Path -af $VolumeOffsetString -c:a $AudioCodec $OutputPath 2>$null
        }
        ".mp3"
        {
            & ffmpeg -y -i $Path -af $VolumeOffsetString -b:a $BitRate $OutputPath 2>$null
        }
        default
        {
            Write-Error "Error: This script does not have a method of normalizing $($File.Extension) files. Update this PowerShell cmdlet to support this behavior."
            return
        }
    }

    # Cleanup if overwriting the input file
    if ($OverwriteInputFile)
    {
        if ($LASTEXITCODE -eq 0) # Check if FFmpeg succeeded
        {
            Remove-Item -Path $Path -Force
            Rename-Item -Path $OutputPath -NewName $File.FullName
        }
        else
        {
            Write-Error "FFmpeg failed: deleting the temp file at $OutputPath"
            Remove-Item -Path $OutputPath -Force
        }
    }
}