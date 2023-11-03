<#
.DESCRIPTION
Renames files in a directory with custom criteria. Edit this script as needed.
#>
function Rename-FilesWithCustomCriteria {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path,
        [Parameter(Mandatory=$false)][switch]$Recurse
    )
  
    Get-ChildItem -Path $Path -Recurse:$Recurse -File | Rename-Item -NewName { $_.Name -Replace ".1080p.WEB-DL.x265.10bit.AAC.5.1-ImE\[UTR\].mkv", "" }
    Get-ChildItem -Path $Path -Recurse:$Recurse -File | Rename-Item -NewName { $_.Name -Replace "\.", " " }
    Get-ChildItem -Path $Path -Recurse:$Recurse -File | Rename-Item -NewName { $_.Name + ".mkv" }        
}