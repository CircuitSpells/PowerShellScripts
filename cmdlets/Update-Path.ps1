<#
.DESCRIPTION
    Updates the current session’s PATH variable without having to restart the terminal.
#>
function Update-Path {
    [CmdletBinding()]
    param ()

    $machinePath = [System.Environment]::GetEnvironmentVariable("Path","Machine")
    $userPath    = [System.Environment]::GetEnvironmentVariable("Path","User")

    $env:Path = "$machinePath;$userPath"

    Write-Host "PATH updated for this session."
}
