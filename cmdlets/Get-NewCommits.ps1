<#
.DESCRIPTION
    Lists all commits that are on the TargetBranch but not on the SourceBranch.
#>
function Get-NewCommits {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)][string]$RepoPath = ".",
        [Parameter(Mandatory = $true)][string]$SourceBranch,
        [Parameter(Mandatory = $true)][string]$TargetBranch,
        [Parameter(Mandatory = $false)][switch]$SkipFetch
    )

    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Error "Git is not installed or not in PATH."
        return
    }

    if (-not $SkipFetch) {
        Write-Host "fetching $SourceBranch"
        & git fetch origin ${SourceBranch}:${SourceBranch}

        Write-Host "fetching $TargetBranch`n"
        & git fetch origin ${TargetBranch}:${TargetBranch}
    }

    $Range = "$SourceBranch..$TargetBranch" # Workaround to ignore the PowerShell ".." syntax
    $Output = & git log $Range --oneline --color=always

    if (-not $Output) {
        Write-Error "No output returned from git. Ensure SourceBranch is a predecessor to the TargetBranch."
    }
    else {
        Write-Output $Output
    }
}
