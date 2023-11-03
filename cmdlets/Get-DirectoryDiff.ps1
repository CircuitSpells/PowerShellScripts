<#
.DESCRIPTION
Compares the files contained in two different directories
#>
function Get-DirectoryDiff {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)][string]$PathA,
        [Parameter(Mandatory=$True)][string]$PathB
    )

    $FullPathA = Resolve-Path -Path $PathA
    $FullPathB = Resolve-Path -Path $PathB

    $PathAFiles = Get-ChildItem -Path $FullPathA -Recurse | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($FullPathA.Path.Length) }
    $PathBFiles = Get-ChildItem -Path $FullPathB -Recurse | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($FullPathB.Path.Length) }

    $DirectoryDiff = Compare-Object -ReferenceObject $PathBFiles -DifferenceObject $PathAFiles

    Write-Host "`nOnly in PathA:"
    $DirectoryDiff | Where-Object { $_.SideIndicator -eq "=>" } | Select-Object -ExpandProperty InputObject

    Write-Host "`nOnly in PathB:"
    $DirectoryDiff | Where-Object { $_.SideIndicator -eq "<=" } | Select-Object -ExpandProperty InputObject
}