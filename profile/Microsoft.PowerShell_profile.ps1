# Place this file and Scripts folder in C:\Users\[UserName]\Documents\PowerShell\
# Place my-theme.omp.json in C:\Users\[UserName]\AppData\Local\Programs\oh-my-posh\themes\

$PathToRepo = "C:\Path\To\PowershellScripts"

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/my-theme.omp.json" | Invoke-Expression
Import-Module "$PathToRepo\PowerShellScripts\StartupModule.psm1" -Force
Set-Alias -Name clera -Value Clear-Host
Set-Alias -Name gh -Value Get-Help

function Set-Location-PowerShellScripts { Set-Location "$PathToRepo\cmdlets" }
Set-Alias -Name cdps -Value 'Set-Location-PowerShellScripts'

function Set-Location-Programming { Set-Location "C:\Users\<username>\source\repos\" }
Set-Alias -Name cdprog -Value 'Set-Location-Programming'

function DisplayCmdlets {
    Get-ChildItem "$PathToRepo\cmdlets"
    Write-Output "Custom functions:"
    Write-Output "    cdps: cd to PowerShellScripts directory"
    Write-Output "    cdtouch: cd to TouchDesigner directory"
    Write-Output "    cdprog: cd to Programming directory"
    Write-Output "    mycmd: List all cmdlets and custom functions"
}
Set-Alias -Name mycmd -Value 'DisplayCmdlets'