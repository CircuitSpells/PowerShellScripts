<#
.DESCRIPTION
    Installs OhMyPosh using winget.
#>
function Install-OhMyPosh {
    [CmdletBinding()]
    param ()

    Import-Module "$PSScriptRoot\Use-Winget.ps1" -Force
    Use-Winget -Command "install" -PackageId "JanDeDobbeleer.OhMyPosh"
}