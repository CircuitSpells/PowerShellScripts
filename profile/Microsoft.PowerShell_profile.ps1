# Place this file and Scripts folder in C:\Users\[UserName]\Documents\PowerShell\
# Place my-theme.omp.json in C:\Users\[UserName]\AppData\Local\Programs\oh-my-posh\themes\

$Username = "<username>"
$RepoPath = "C:\Users\$Username\source\repos\"
$PathToRepo = "$RepoPath\Path\To\PowerShellScripts"

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/my-theme.omp.json" | Invoke-Expression
Import-Module "$PathToRepo\StartupModule.psm1" -Force
Set-Alias -Name clera -Value Clear-Host
Set-Alias -Name gh -Value Get-Help

function Set-Location-PowerShellScripts { Set-Location "$PathToRepo\cmdlets" }
Set-Alias -Name cdps -Value 'Set-Location-PowerShellScripts'

function Set-Location-Programming { Set-Location $RepoPath }
Set-Alias -Name cdprog -Value 'Set-Location-Programming'

function DisplayCmdlets {
    Get-ChildItem "$PathToRepo\cmdlets" | Where-Object { $_.Extension -eq ".ps1" } | Select-Object -ExpandProperty Name
    Write-Output ""
    Write-Output "mycmd: list all cmdlets and custom functions"
    Write-Output "cdps: cd to PowerShellScripts directory"
    Write-Output "cdprog: cd to Programming directory"
    Write-Output "cdmr: cd to MonoRepo"
}
Set-Alias -Name mycmd -Value 'DisplayCmdlets'