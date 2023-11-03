$PathToCmdlets = $PSScriptRoot + '\cmdlets\'
Get-ChildItem -Path $PathToCmdlets -Filter *.ps1 | ForEach-Object {
    Get-Command -Name * -Module (Import-Module -Name $_.FullName -Force -PassThru) -CommandType Cmdlet
} | Export-ModuleMember -Cmdlet -Force