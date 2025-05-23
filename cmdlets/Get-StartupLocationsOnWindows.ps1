<#
.DESCRIPTION
    Lists all startup locations on Windows
#>
function Get-StartupLocationsOnWindows {
    [CmdletBinding()]
    param ()
    
    Write-Host
    Write-Host "Windows Settings:"
    Write-Host "`tWindows search and select 'startup apps'. Items listed here also appear in Task Manager's startup tab."

    Write-Host
    Write-Host "Explorer:"
    Write-Host "`tshell:startup"
    Write-Host "`tshell:common startup"

    Write-Host
    Write-Host "Task Scheduler:"
    Write-Host "`tOpen Task Scheduler (helps to fullscreen) and look under 'Active tasks'"

    Write-Host
    Write-Host "Registry:"
    Write-Host "`tHKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"
    Write-Host "`t`tFor currently logged in user"
    Write-Host "`tHKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce"
    Write-Host "`t`tFor currently logged in user, runs once on next startup and then is removed"
    Write-Host "`tHKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run"
    Write-Host "`t`tFor all users"
    Write-Host "`tHKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce"
    Write-Host "`t`tFor all users, runs once on next startup and then is removed"

    Write-Host
    Write-Host "Services:"
    Write-Host "`tOpen the Services app (helps to fullscreen) and sort items by 'startup type'"
    Write-Host "`t`t'Automatic' services begin at startup"
    Write-Host "`t`t'Automatic (delayed)' services begin after a short delay after startup to improve startup performance"
    Write-Host "`t`t'Automatic (Trigger Start)' services begin after an event, which can include logging in"
    Write-Host "`t`tNote: If a dependency fails to start, the service configured as 'Automatic' may not start either. In some cases, services may not start immediately due to system load or specific conditions that delay their startup"
    Write-Host "`tTo change startup type, right click the service > Properties, then change the 'startup type' dropdown to 'disabled'"
    Write-Host "`tYou can find these same services with the Get-Service PowerShell cmdlet"

    Write-Host
    Write-Host "Group Policy Editor:"
    Write-Host "`tTypically only for business environments"
}