<#
.DESCRIPTION
Uses ffmpeg to normalize an audio file to a specified true peak value (default is 0dBFS)
#>
function ConvertTo-NormalizedAudioFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$false)][float]$TargetTruePeak = 0,
        [Parameter(Mandatory=$false)][switch]$OverwriteInputFile
    )

    if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue))
    {
        Write-Error "ffmpeg not installed. Run the 'Install-FFmpeg' cmdlet to install it."
        return
    }
    
    if (!(Test-Path -Path $Path))
    {
        Write-Error "File not found"
        return
    }

    if ($TargetTruePeak -gt 0)
    {
        Write-Error "TargetTruePeak must be equal to or less than 0"
        return
    }

    # Get Volume Offset
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

    # Get Bit Depth
    # todo: support mp3 and other audio formats besides wav
    $BitDepth = & ffprobe -v error -select_streams a:0 -show_entries stream=bits_per_raw_sample -of default=noprint_wrappers=1:nokey=1 $Path
    $Codec = switch ($BitDepth)
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

    # Get Output Path
    $OutputPath
    $File = Get-Item $Path
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
            if (!(Test-Path -Path $OutputPath))
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
    
    # Print Info
    Write-Output "Input Path:" $Path
    Write-Output "Volume Offset: $VolumeOffset"
    Write-Output "Output Path: $OutputPath"

    # Create Normalized File
    & ffmpeg -y -i $Path -af $VolumeOffsetString -c:a $Codec $OutputPath 2>$null

    if ($OverwriteInputFile)
    {
        if ($LASTEXITCODE -eq 0) # Check if FFmpeg succeeded
        {
            Remove-Item -Path $Path -Force
            Rename-Item -Path $OutputPath -NewName $File.FullName
        }
        else
        {
            Write-Error "FFmpeg failed: deleting temp file"
            Remove-Item -Path $OutputPath -Force
        }
    }
}