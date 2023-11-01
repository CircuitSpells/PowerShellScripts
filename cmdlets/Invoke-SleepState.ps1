function Invoke-SleepState {
    [CmdletBinding()]
    param ()
    
    process {
        & rundll32.exe powrprof.dll,SetSuspendState 0,1,0
    }
}