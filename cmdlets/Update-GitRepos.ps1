<#
.DESCRIPTION
    Recursively runs git pull
#>
function Update-GitRepos {
    [CmdletBinding()]
    param(
        [string]$Path = (Get-Location).Path
    )

    Write-Host "Finding repos..."
    $gitDirs = Get-ChildItem -Path $Path -Recurse -Directory -Force -ErrorAction SilentlyContinue | Where-Object { $_.Name -eq '.git' } 
    $repos = $gitDirs | ForEach-Object { $_.Parent.FullName } | Sort-Object -Unique

    if (-not $repos) {
        Write-Host "No Git repositories found under: $Path"
        return
    }

    foreach ($repo in $repos) {
        Write-Host "────────────────────────────────────────"
        Write-Host "Updating repo: $repo"
        & git -C $repo pull --ff-only
    }
}