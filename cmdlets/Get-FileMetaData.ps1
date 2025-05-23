<#
.DESCRIPTION
    Uses mediainfo to get the metadata of a file. Optional parameter to extract information relevant to Instagram Reels upload requirements.
#>
function Get-FileMetaData {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $false)][switch]$InstagramReelsStats
    )

    if (-not (Get-Command mediainfo -ErrorAction SilentlyContinue)) {
        Write-Host "mediainfo not installed. Run the 'Install-FFmpeg' cmdlet to install it."
        return
    }

    if (!(Test-Path -Path $Path))
    {
        Write-Host "File not found"
        return
    }
  
    $FileStats = (& mediainfo $Path) -join "`n"

    $AudioAnalysis = ffmpeg -i $Path -af loudnorm=print_format=json -f null - 2>&1 | Out-String
    $JsonStart = $AudioAnalysis.IndexOf("{")
    $JsonEnd = $AudioAnalysis.LastIndexOf("}") + 1
    $JsonLoudnessInfo = $AudioAnalysis.Substring($JsonStart, $JsonEnd - $JsonStart)
    $LoudnessInfo = $JsonLoudnessInfo | ConvertFrom-Json

    Write-Host $FileStats
    Write-Host "Loudness Info"
    Write-Host "Integrated Loudness (LUFS)`t`t: $($LoudnessInfo.input_i)"
    Write-Host "True Peak (dBTP)`t`t`t: $($LoudnessInfo.input_tp)"
    Write-Host "Loudness Range (LU)`t`t`t: $($LoudnessInfo.input_lra)"
    Write-Host "Input Threshold`t`t`t`t: $($LoudnessInfo.input_thresh)"

    if ($InstagramReelsStats) {

        if ($Path.Substring($Path.Length - 3) -ne "mp4") {
            Write-Host "Instagram requires an .mp4 file. Run the 'ConvertTo-Mp4' cmdlet to convert the file to .mp4."
            return
        }

        $ProgressiveScan = ($FileStats | Select-String "Scan type\s*: Progressive").Length -gt 0
        $HighProfile = ($FileStats | Select-String "Format profile\s*: High").Length -gt 0
        $TwoConsecutiveBFrames = ($FileStats | Select-String "bframes=2").Length -gt 0
        $ClosedGOPofHalfTheFrameRate = ($FileStats | Select-String "open_gop=0").Length -gt 0
        $CABAC = ($FileStats | Select-String "CABAC\s*: Yes").Length -gt 0
        $ChromaSubsampling420 = ($FileStats | Select-String "Chroma subsampling\s*: 4:2:0").Length -gt 0
        $AudioSamplingRate = (($FileStats | Select-String "Sampling rate\s*: 48.0 kHz").Length -gt 0) -or (($FileStats | Select-String "Sampling rate\s*: 96.0 kHz").Length -gt 0)
    
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