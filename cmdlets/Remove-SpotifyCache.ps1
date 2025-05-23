<#
.DESCRIPTION
Removes the Spotify cache. Spotify can sometimes slow down when the cache gets too large.
#>
function Remove-SpotifyCache {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)][string]$UserName = $env:USERNAME
    )

    $Path = "C:\Users\$UserName\AppData\Local\Spotify\Data\"

    Get-ChildItem $Path | Remove-Item  -Recurse -Force
    Write-Host "Spotify cache deleted at $Path"
}