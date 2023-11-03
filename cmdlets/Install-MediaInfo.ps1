<#
.DESCRIPTION
Installs MediaInfo using winget.
#>
function Install-MediaInfo {
    [CmdletBinding()]
    param ()
    
    Import-Module "$PSScriptRoot\Assert-IsAdmin.ps1" -Force

    if (-not (Assert-IsAdmin)) {
        Write-Host "This script must be run as an administrator"
        return
    }
    
    & winget install MediaInfo-CLI -e
}