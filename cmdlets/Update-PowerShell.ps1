<#
.DESCRIPTION
Updates the latest PowerShell version using winget.
#>
function Update-PowerShell {
    [CmdletBinding()]
    param ()
    
    if (-not (Assert-IsAdmin)) {
        Write-Host "This script must be run as an administrator"
        return
    }

    & winget upgrade --id Microsoft.Powershell
}