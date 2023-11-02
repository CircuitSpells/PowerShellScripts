function Get-DirectoryDiff {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)][string]$BeforePath,
        [Parameter(Mandatory=$True)][string]$AfterPath
    )

    Write-Host "Warning: I don't know why, but this only works if you run this manually and not as a Cmdlet"

    $BeforeFiles = Get-ChildItem -Path $BeforePath -Recurse | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($BeforePath.Path.Length) }
    $AfterFiles = Get-ChildItem -Path $AfterPath -Recurse | Select-Object -ExpandProperty FullName | ForEach-Object { $_.Substring($AfterPath.Path.Length) }

    Write-Host "`nOnly in AfterPath:"
    Compare-Object -ReferenceObject $AfterFiles -DifferenceObject $BeforeFiles | Where-Object { $_.SideIndicator -eq "<=" } | Select-Object -ExpandProperty InputObject

    Write-Host "`nOnly in BeforePath:"
    Compare-Object -ReferenceObject $AfterFiles -DifferenceObject $BeforeFiles | Where-Object { $_.SideIndicator -eq "=>" } | Select-Object -ExpandProperty InputObject
}