<#
.DESCRIPTION
    Returns the relative paths to all csproj files referenced in an sln file.
#>
function Get-CsprojPathsFromSln {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$SolutionPath,
        [Parameter(Mandatory=$false)][string]$PackageToFind
    )

    Write-Host "Note: this script requires nuget-tree: npm install -g nuget-tree`n"
    
    $CallingDirectory = Get-Location
    $SlnDirectory = Resolve-Path $SolutionPath | Split-Path

    Get-Content $SolutionPath |
    Select-String 'Project\(' |
    Select-String "{2150E333-8FDC-42A3-9474-1A3956D46DE8}" -NotMatch |
    ForEach-Object {
      $projectParts = $_ -Split '[,=]' | ForEach-Object { $_.Trim('[ "{}]') };
      New-Object PSObject -Property @{
        Name = $projectParts[1];
        File = $projectParts[2];
        Guid = $projectParts[3]
      }
    } |
    ForEach-Object {
        Write-Host $_.File
        $RelativeCsProjDirectory = Split-Path $_.File
        $FullPath = $SlnDirectory + "\" + $RelativeCsprojDirectory
        Set-Location $FullPath
        if ($PSBoundParameters.ContainsKey('PackageToFind'))
        {
            & nuget-tree --why $PackageToFind
        }
        else
        {
            & nuget-tree
        }
    }

    Set-Location $CallingDirectory
}