<#
.DESCRIPTION
Find if a verb exists in the list of approved PowerShell verbs.
#>
function Find-Verb {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Verb
    )
    
    Get-Verb | Select-Object Verb | Select-String $Verb
}