<#
.DESCRIPTION
    Uses winget to install or update packages.
#>
function Use-Winget {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet("install", "upgrade")][string]$Command,
        [Parameter(Mandatory = $true)][string]$PackageId
    )

    Import-Module "$PSScriptRoot\Assert-IsAdmin.ps1" -Force

    if (-not (Assert-IsAdmin)) {
        Write-Host "Re-launching with admin privileges..."
        $psi = @{
            FilePath = "powershell.exe"
            ArgumentList = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
            Verb = "RunAs"
        }
        Start-Process @psi
    }

    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Running winget $Command...`n"
        & winget $Command --id $PackageId --source winget --accept-source-agreements --accept-package-agreements

        if ($Command -eq "install") {
            Write-Host
            Import-Module "$PSScriptRoot\Update-Path.ps1" -Force
            Update-Path
        }
    } else {
        Write-Host "winget not found. Please install Windows Package Manager."
    }
}