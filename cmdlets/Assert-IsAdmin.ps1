<#
.DESCRIPTION
    Asserts that the current user is an administrator.
#>
function Assert-IsAdmin {
    [CmdletBinding()]
    param ()

    return ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}