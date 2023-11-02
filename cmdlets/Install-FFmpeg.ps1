function Install-FFmpeg {
    [CmdletBinding()]
    param ()

    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "This script must be run as an administrator"
        return
    }
    
    & winget install FFmpeg -e
}