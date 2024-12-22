<#
.DESCRIPTION

#>
function ConvertTo-NormalizedAudioFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$false)][float]$TargetTruePeak = 0,
        [Parameter(Mandatory=$false)][switch]$Recurse
    )

    if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue))
    {
        Write-Host "ffmpeg not installed. Run the 'Install-FFmpeg' cmdlet to install it."
        return
    }
    
    if (!(Test-Path -Path $Path))
    {
        Write-Host "File not found"
        return
    }

    if ($TargetTruePeak -gt 0)
    {
        Write-Host "TargetTruePeak must be equal to or less than 0"
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
    $BitDepth = & ffprobe -v error -select_streams a:0 -show_entries stream=bits_per_raw_sample -of default=noprint_wrappers=1:nokey=1 $Path
    $Codec = switch ($BitDepth)
    {
        "16" { "pcm_s16le" }
        "24" { "pcm_s24le" }
        "32" { "pcm_s32le" }
        Default { Write-Error "Unsupported bit depth"; exit }
    }

    # $VolumeOffset = ($TruePeak -ge 0) ? 0 : -$TruePeak # TruePeak is negative, so we force the value to positive. If TruePeak is greater than 0, the audio is clipping so in that case force to 0
    # $Headroom = ($Headroom -ge 0) ? $Headroom : -$Headroom # users can enter either a positive or negative number (the result will be the same), but we force the value to positive
    # $VolumeOffset -= $Headroom

    # Get Output Path
    $File = Get-Item $Path
    $OutputPath = "$($File.DirectoryName)\$($File.BaseName)_Normalized$($File.Extension)"
    # todo: add _1 to output name and increment if file exists
    # todo: add option to overwrite input file
    
    # Print Info
    Write-Output "Input Path:" $Path
    Write-Output "Volume Offset: $VolumeOffset"
    Write-Output "Output Path: $OutputPath"

    # Create Normalized File
    # todo: add back 2>$null
    & ffmpeg -y -i $Path -af $VolumeOffsetString -c:a $Codec $OutputPath
}