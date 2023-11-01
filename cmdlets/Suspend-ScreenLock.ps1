function Suspend-ScreenLock {
    [CmdletBinding()]
    param ()
    
    process {
        $Shell = New-Object -ComObject Wscript.Shell
        $i = 0
        while ($true) {
            Write-Host "Boop $i"
            $Shell.SendKeys('{F15}')
            $i++
            Start-Sleep -Seconds 60
        }
    }
}