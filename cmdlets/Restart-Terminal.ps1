<#
.DESCRIPTION
Restarts the terminal session in the current directory. Useful to quickly import new and updated cmdlets from the 'PowerShellScripts\cmdlets' directory.
#>
function Restart-Terminal {
    [CmdletBinding()]
    param ()
    
    $CurrentDirectory = Get-Location
    & wt -w 0 pwsh -noexit -command "Set-Location $CurrentDirectory"
    exit
}