function Rename-AllItemsWithPrefix {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$true)][string]$Prefix,
        [Parameter(Mandatory=$false)][switch]$Recurse
    )
    
    process {
        Get-ChildItem -Path $Path -File -Recurse:$Recurse | Rename-Item -NewName { $Prefix + $_.Name }
    }
}