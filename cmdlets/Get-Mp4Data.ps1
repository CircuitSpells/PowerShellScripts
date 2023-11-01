<#
.DESCRIPTION
Gets the data of a video file relevant to Instagram reels using ffmpeg.
#>
function Get-Mp4Data {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Path
    )
  
    process {
        $Mp4Stats = & ffmpeg -i $Path 2>&1

        $ProgressiveScan = ($Mp4Stats | Select-String "Progressive:").Length -gt 0
        $HighProfile = ($Mp4Stats | Select-String "Profile: High").Length -gt 0
        $TwoConsecutiveBFrames = ($Mp4Stats | Select-String "B-frames: 2").Length -gt 0
        $ClosedGOPofHalfTheFrameRate = ($Mp4Stats | Select-String "closed: 1, references: 2").Length -gt 0
        $CUBAC = ($Mp4Stats | Select-String "cabac: 1").Length -gt 0
        $ChromaSubsampling420 = ($Mp4Stats | Select-String "yuv420p").Length -gt 0

        Write-Host "Progressive Scan: $ProgressiveScan"
        Write-Host "High Profile: $HighProfile"
        Write-Host "Two Consecutive B Frames: $TwoConsecutiveBFrames"
        Write-Host "Closed GOP of Half the Frame Rate: $ClosedGOPofHalfTheFrameRate"
        Write-Host "CUBAC: $CUBAC"
        Write-Host "Chroma Subsampling 4:2:0: $ChromaSubsampling420"
    }
}