function Rename-AllItemsWithPrefix {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$true)][string]$Prefix
    )
    
    process {
        Get-ChildItem -Path $Path -File | Rename-Item -NewName { $Prefix + $_.Name }
    }
}