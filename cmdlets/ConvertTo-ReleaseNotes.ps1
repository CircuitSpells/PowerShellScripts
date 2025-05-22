<#
.DESCRIPTION
    Converts output of `git log source..target --oneline` to a release notes markdown file

.Example
    Get-NewCommits -SourceBranch prod/sourceBranch -TargetBranch prod/targetBranch |
        ConvertTo-ReleaseNotes -FileName 'Release-Notes-v1.4.0.md' -OutputPath '.\Releases'
#>
function ConvertTo-ReleaseNotes {
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0)]
        [string] $InputObject,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string] $FileName = 'Release-Notes.md',

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string] $OutputPath = '.',

        [Parameter(Mandatory = $false)]
        [switch] $ReverseOrder
    )

    begin {
        $Messages = @()
        $Pattern = '^\w+\s+Merged PR \d+:\s+(.*)$'
    }

    process {
        if ($InputObject -match $Pattern) {
            $Messages += $Matches[1] # $Matches is an automatic variable created from the -match operator
        }
        else {
            Write-Warning "No matches found for the InputObject: $InputObject"
        }
    }

    end {
        if (-not $Messages) {
            Write-Warning "No commit messages found to write."
            return
        }

        $Output = "# Release Notes`n`n"
        if ($ReverseOrder) {
            [array]::Reverse($Messages) # Reverse order so that items are sorted chronologically
        }
        $Messages | ForEach-Object {
            $Output += "- $_`n"
        }

        $FullPath = Join-Path -Path $OutputPath -ChildPath $FileName
        
        # Create output directory if it doesn't exist
        $Dir = Split-Path -Parent $FullPath
        if (-not (Test-Path -LiteralPath $Dir)) {
            New-Item -ItemType Directory -Path $Dir -Force | Out-Null
        }

        $Output | Set-Content -Path $FullPath -Encoding UTF8

        Write-Host "`nRelease notes written to '$FullPath':`n"
        Write-Host $Output
    }
}
