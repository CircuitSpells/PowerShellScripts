<#
.DESCRIPTION
Converts a video file to mp4 format using ffmpeg. Currently only tested with .mov files.
#>
function ConvertTo-Mp4 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path
    )

    process {
        if (!(Test-Path -Path $Path))
        {
            Write-Host "File not found"
            return
        }

        $FileExtensionLength = $Path.Split(".")[-1].Length
        $NewName = $Path.Substring(0, $Path.Length - $FileExtensionLength) + "mp4"
        & ffmpeg -i $Path -c copy $NewName
    }
}