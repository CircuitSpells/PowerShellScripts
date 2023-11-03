<#
.DESCRIPTION
Restarts Explorer. This script was created to fix a Windows 11 bug where changing multi-monitor setups causes some windows to cover the taskbar.
#>
function Restart-Explorer {
    [CmdletBinding()]
    param ()
    
    Get-Process -Name "explorer" | Stop-Process -Force
    Start-Sleep -Seconds 3
    & explorer.exe
}