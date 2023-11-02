oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/my-theme.omp.json" | Invoke-Expression
Import-Module "<PathToRepo>\PowerShellScripts\MyPowerShellModule.psm1" -Force
Set-Alias -Name clera -Value Clear-Host
Set-Alias -Name gh -Value Get-Help