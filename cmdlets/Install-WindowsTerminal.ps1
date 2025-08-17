<#
.DESCRIPTION
    Installs Windows Terminal using winget.
#>
function Install-WindowsTerminal {
    [CmdletBinding()]
    param ()

    Import-Module "$PSScriptRoot\Use-Winget.ps1" -Force
    Use-Winget -Command "install" -PackageId "Microsoft.WindowsTerminal"
}