<#
.DESCRIPTION
Gets the size of a directory in bytes. Optionally allows for ignoring files with certain extensions. Use the -Verbose switch to see which files are being ignored.
#>
function Get-DirectorySize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $false)][string[]]$IgnoreFileExtensions = @('.mov', '.mp4', '.mkv'),
        [Parameter(Mandatory = $false)][switch]$Recurse
    )

    $Size = 0

    Get-ChildItem -Path $Path -File -Recurse:$Recurse | ForEach-Object {
        if($IgnoreFileExtensions -contains $_.Extension) {
            if ($PSBoundParameters['Verbose']) {
                Write-Host "Ignoring $($_.FullName)"
            }
        }
        else {
            if ($PSBoundParameters['Verbose']) {
                Write-Host "Adding $($_.FullName)"
            }
            
            $Size += $_.Length
        }
    }
    
    Write-Host "`n$($Size.ToString('N0')) bytes"
}