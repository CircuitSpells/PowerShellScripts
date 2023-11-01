function Get-DirectorySize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $false)][string[]]$IgnoreFileExtensions = @('.mov', '.mp4', '.mkv'),
        [Parameter(Mandatory = $false)][switch]$Recurse
    )

    process {
        $Size = 0

        Get-ChildItem -Path $Path -File -Recurse:$Recurse | ForEach-Object {
            if($IgnoreFileExtensions -contains $_.Extension) {
                if ($PSBoundParameters['Verbose']) {
                    Write-Output "Ignoring $($_.FullName)"
                }
            }
            else {
                if ($PSBoundParameters['Verbose']) {
                    Write-Output "Adding $($_.FullName)"
                }
                
                $Size += $_.Length
            }
        }
        
        Write-Output "`n$($Size.ToString('N0')) bytes"
    }
}