<#
.DESCRIPTION
Returns the BPM of a song synced to a video given the number of frames in the video and number of beats in the song.
#>
function Convert-FramesToBpm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][float]$NumFrames,
        [Parameter(Mandatory = $true)][int]$NumBeats,
        [Parameter(Mandatory = $false)][int]$FrameRate = 60
    )

    $SongLength = $NumFrames / $FrameRate
    $Bpm = 60 / ($SongLength / $NumBeats)
    
    Write-Output "Length: $SongLength seconds"
    Write-Output "Bpm: $Bpm"
}