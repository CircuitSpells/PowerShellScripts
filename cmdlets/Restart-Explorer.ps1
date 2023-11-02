function Restart-Explorer {
    [CmdletBinding()]
    param ()
    
    Get-Process -Name "explorer" | Stop-Process -Force
    Start-Sleep -Seconds 3
    & explorer.exe
}