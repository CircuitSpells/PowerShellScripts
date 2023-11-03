<#
.DESCRIPTION
Uses mediainfo to get the data of a video file. Optional parameter to extract information relevant to Instagram Reels upload requirements.
#>
function Get-Mp4Data {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $false)][switch]$InstagramReelsStats
    )

    if(-not (Get-Command mediainfo -ErrorAction SilentlyContinue)) {
        Write-Host "mediainfo not installed. Run the 'Install-FFmpeg' cmdlet to install it."
        return
    }

    if (!(Test-Path -Path $Path))
    {
        Write-Host "File not found"
        return
    }
  
    $Mp4Stats = (& mediainfo $Path) -join "`n"

    Write-Output $Mp4Stats

    if($InstagramReelsStats) {
        $ProgressiveScan = ($Mp4Stats | Select-String "Scan type\s*: Progressive").Length -gt 0
        $HighProfile = ($Mp4Stats | Select-String "Format profile\s*: High").Length -gt 0
        $TwoConsecutiveBFrames = ($Mp4Stats | Select-String "bframes=2").Length -gt 0
        $ClosedGOPofHalfTheFrameRate = ($Mp4Stats | Select-String "open_gop=0").Length -gt 0
        $CABAC = ($Mp4Stats | Select-String "CABAC\s*: Yes").Length -gt 0
        $ChromaSubsampling420 = ($Mp4Stats | Select-String "Chroma subsampling\s*: 4:2:0").Length -gt 0
        $AudioSamplingRate = (($Mp4Stats | Select-String "Sampling rate\s*: 48.0 kHz").Length -gt 0) -or (($Mp4Stats | Select-String "Sampling rate\s*: 96.0 kHz").Length -gt 0)
    
        Write-Host "Instagram Reels Stats:"
        Write-Host "`tProgressive Scan: $ProgressiveScan"
        Write-Host "`tHigh Profile: $HighProfile"
        Write-Host "`tTwo Consecutive B Frames: $TwoConsecutiveBFrames"
        Write-Host "`tClosed GOP of Half the Frame Rate: $ClosedGOPofHalfTheFrameRate"
        Write-Host "`tCUBAC: $CABAC"
        Write-Host "`tChroma Subsampling 4:2:0: $ChromaSubsampling420"
        Write-Host "`tAudio Sampling Rate at 48kHz or 96kHz: $AudioSamplingRate"
    }
}