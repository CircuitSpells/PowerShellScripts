<#
.DESCRIPTION
    Uses ffprobe to get the number of frames in a video file.
#>
function Get-FrameCount {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path
    )

    if(-not (Get-Command ffprobe -ErrorAction SilentlyContinue)) {
        Write-Host "ffmpeg not installed. Run the 'Install-FFmpeg' cmdlet to install it."
        return
    }
    
    if (!(Test-Path -Path $Path))
    {
        Write-Host "File not found"
        return
    }

    & ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_read_frames -of csv=p=0 $Path
}