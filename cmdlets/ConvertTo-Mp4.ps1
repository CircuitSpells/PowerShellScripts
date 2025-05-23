<#
.DESCRIPTION
    Uses ffmpeg to convert a video file to .mp4 without changing the video's codec. This process is known as "demuxing", which means that the video file's *container* format changes (such as .mov to .mp4), but not the video file's *codec* (such as h.264 or MPEG-2 Part 2). This cmdlet has currently only been tested with .mov files with the "MPEG 4 Part 2" codec.
#>
function ConvertTo-Mp4 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path
    )

    if(-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
        Write-Host "ffmpeg not installed. Run the 'Install-FFmpeg' cmdlet to install it."
        return
    }

    if (!(Test-Path -Path $Path))
    {
        Write-Host "File not found"
        return
    }

    $FileExtensionLength = $Path.Split(".")[-1].Length
    $NewName = $Path.Substring(0, $Path.Length - $FileExtensionLength) + "mp4"
    & ffmpeg -i $Path -c copy $NewName
}