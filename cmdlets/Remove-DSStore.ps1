<#
.DESCRIPTION
    Removes all .DS_Store files in a directory.
#>
function Remove-DSStore {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$false)][switch]$Recurse
    )
    
    Get-ChildItem -Path $Path -File -Recurse:$Recurse | Where-Object {$_.Name -eq ".DS_Store"} | Remove-Item -Force
}