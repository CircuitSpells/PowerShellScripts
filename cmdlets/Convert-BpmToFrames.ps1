<#
.DESCRIPTION
    Returns the number of frames in a video that is synced to a song given the song's BPM and the total number of beats.
#>
function Convert-BpmToFrames {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][float]$Bpm,
        [Parameter(Mandatory = $true)][int]$NumBeats,
        [Parameter(Mandatory = $false)][int]$FrameRate = 60
    )

    $SongLength = (60 / $Bpm) * $NumBeats 
    $NumFrames = $SongLength * $FrameRate
    
    Write-Host "Length: $SongLength seconds"
    Write-Host "Frame Count: $NumFrames"
}