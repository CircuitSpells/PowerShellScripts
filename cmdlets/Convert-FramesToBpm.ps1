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