<#
.DESCRIPTION
Edit this script as needed to batch rename files.
#>
function Rename-FilesWithCustomCriteria {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$Path
    )
  
    Get-ChildItem -Path $Path -Recurse -File | Rename-Item -NewName { $_.Name -Replace "Parks.and.Recreation.", "" }
    Get-ChildItem -Path $Path -Recurse -File | Rename-Item -NewName { $_.Name -Replace ".1080p.WEB-DL.x265.10bit.AAC.5.1-ImE\[UTR\].mkv", "" }
    Get-ChildItem -Path $Path -Recurse -File | Rename-Item -NewName { $_.Name -Replace "\.", " " }
    Get-ChildItem -Path $Path -Recurse -File | Rename-Item -NewName { $_.Name + ".mkv" }        
}