<#
.DESCRIPTION
This script fixes an issue where an Xbox One controller will not pair with a PC. To find the MAC address of the controller, go to Control Panel->Hardware and Sound->Devices and Printers, right click the controller and click properties of the device. The MAC address will be under the field "Unique identifier".
#>
function Disconnect-XboxControllerFromPreviousDevice {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)][string]$ControllerMacAddress = '44:16:22:1a:8b:a7'
    )
    
    & btpair -u -b $ControllerMacAddress
}