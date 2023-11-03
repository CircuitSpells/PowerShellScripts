<#
.DESCRIPTION
Compares the files between two different directories
#>
function Get-DirectoryDiff {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)][string]$PathA,
        [Parameter(Mandatory=$True)][string]$PathB
    )

    Write-Host "Warning: I don't know why, but this only works if you run this manually and not as a Cmdlet"

    $PathAFiles = Get-ChildItem -Path $PathA -Recurse | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($PathA.Path.Length) }
    $PathBFiles = Get-ChildItem -Path $PathB -Recurse | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($PathB.Path.Length) }

    Write-Host "`nOnly in PathA:"
    Compare-Object -ReferenceObject $PathBFiles -DifferenceObject $PathAFiles | Where-Object { $_.SideIndicator -eq "=>" } | Select-Object -ExpandProperty InputObject

    Write-Host "`nOnly in PathB:"
    Compare-Object -ReferenceObject $PathBFiles -DifferenceObject $PathAFiles | Where-Object { $_.SideIndicator -eq "<=" } | Select-Object -ExpandProperty InputObject
}