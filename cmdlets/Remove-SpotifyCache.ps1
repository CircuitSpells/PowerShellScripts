<#
.DESCRIPTION
Removes the Spotify cache. Spotify can sometimes slow down when the cache gets too large.
#>
function Remove-SpotifyCache {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)][string]$UserName = $env:USERNAME
    )

    Get-ChildItem "C:\Users\$UserName\AppData\Local\Spotify\Data\" | Remove-Item  -Recurse -Force
    Write-Host "Spotify cache deleted"
}