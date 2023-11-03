function Convert-FrameToBpm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][float]$NumFrames,
        [Parameter(Mandatory = $true)][int]$NumBeats,
        [Parameter(Mandatory = $false)][int]$FrameRate = 60
    )
    
    # $SongLength = (60 / $Bpm) * $NumBeats 
    # $NumFrames = $SongLength * $FrameRate

    $SongLength = $NumFrames / $FrameRate
    $Bpm = 60 / ($SongLength / $NumBeats)
    
    Write-Output "Length: $SongLength seconds"
    Write-Output "Bpm: $Bpm"
}