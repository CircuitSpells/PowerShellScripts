<#
.DESCRIPTION
    Installs the latest PowerShell version using winget.
#>
function Install-PowerShell {
    [CmdletBinding()]
    param ()

    Import-Module "$PSScriptRoot\Use-Winget.ps1" -Force
    Use-Winget -Command "install" -PackageId "Microsoft.PowerShell"
}