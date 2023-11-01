function Remove-SpotifyCache {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)][string]$UserName = 'Drake'
    )

    process {
        Get-ChildItem "C:\Users\$UserName\AppData\Local\Spotify\Data\" | Remove-Item  -Recurse -Force
        Write-Host "Spotify cache deleted..."
    }
}