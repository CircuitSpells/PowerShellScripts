<#
.DESCRIPTION
    Installs ffmpeg using winget.
#>
function Install-FFmpeg {
    [CmdletBinding()]
    param ()

    Import-Module "$PSScriptRoot\Use-Winget.ps1" -Force
    Use-Winget -Command "install" -PackageId "Gyan.FFmpeg"
}