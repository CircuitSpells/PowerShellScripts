<#
.DESCRIPTION
    Puts the computer to sleep.
#>
function Invoke-SleepState {
    [CmdletBinding()]
    param ()
    
    & rundll32.exe powrprof.dll,SetSuspendState 0,1,0
}