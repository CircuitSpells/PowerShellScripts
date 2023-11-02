function Install-FFmpeg {
    [CmdletBinding()]
    param ()

    if (-not (Assert-IsAdmin)) {
        Write-Host "This script must be run as an administrator"
        return
    }
    
    & winget install FFmpeg -e
}