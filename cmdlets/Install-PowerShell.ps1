<#
.DESCRIPTION
Installs the latest PowerShell version using winget.
#>
function Install-PowerShell {
    [CmdletBinding()]
    param()

    if (-not (Assert-IsAdmin)) {
        Write-Host "This script must be run as an administrator"
        return
    }

    & winget install Microsoft.PowerShell -e
}