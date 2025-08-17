<#
.DESCRIPTION
    Updates the latest PowerShell version using winget.
#>
function Update-PowerShell {
    [CmdletBinding()]
    param ()

    Import-Module "$PSScriptRoot\Use-Winget.ps1" -Force
    Use-Winget -Command "upgrade" -PackageId "Microsoft.PowerShell"
}