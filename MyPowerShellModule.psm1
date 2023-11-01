# usage: place the following line in 'C:\Users\<UserName>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1':
# Import-Module "<PathToRepo>\PowershellScripts\MyPowerShellModule.psm1" -Force

$PathToCmdlets = $PSScriptRoot + '\cmdlets\'
Get-ChildItem -Path $PathToCmdlets -Filter *.ps1 | ForEach-Object {
    Get-Command -Name * -Module (Import-Module -Name $_.FullName -Force -PassThru) -CommandType Cmdlet
} | Export-ModuleMember -Cmdlet -Force