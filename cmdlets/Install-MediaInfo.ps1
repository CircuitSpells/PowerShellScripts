<#
.DESCRIPTION
    Installs MediaInfo using winget.
#>
function Install-MediaInfo {
    [CmdletBinding()]
    param ()

    Import-Module "$PSScriptRoot\Use-Winget.ps1" -Force
    Use-Winget -Command "install" -PackageId "MediaArea.MediaInfo"
}