function Convert-BpmToFrames {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][float]$Bpm,
        [Parameter(Mandatory = $true)][int]$NumBeats,
        [Parameter(Mandatory = $false)][int]$FrameRate = 60
    )

    $SongLength = (60 / $Bpm) * $NumBeats 
    $NumFrames = $SongLength * $FrameRate
    
    Write-Output "Length: $SongLength seconds"
    Write-Output "Frame Count: $NumFrames"
}