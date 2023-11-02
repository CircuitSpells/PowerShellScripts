<#
.DESCRIPTION
Gets the number of frames in a video file using ffprobe.
#>
function Get-FrameCount {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path
    )
    
    if (!(Test-Path -Path $Path))
    {
        Write-Host "File not found"
        return
    }

    & ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_read_frames -of csv=p=0 $Path
}