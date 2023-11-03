function Restart-Terminal {
    [CmdletBinding()]
    param ()
    
    $CurrentDirectory = Get-Location
    & wt -w 0 pwsh -noexit -command "Set-Location $CurrentDirectory"
    exit
}