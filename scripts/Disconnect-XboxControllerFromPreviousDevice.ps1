<#
.DESCRIPTION
This script fixes a bug where an Xbox One controller will not pair with Windows due to previously connecting to another device. To find the MAC address of the controller, go to "Control Panel"->"Hardware and Sound"->"Devices and Printers", then right click the xbox controller and select "properties". The MAC address will be on the "Connected Device" tab in the "Unique identifier" field.
#>
function Disconnect-XboxControllerFromPreviousDevice {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)][string]$ControllerMacAddress # will look something like '44:16:22:1a:8b:a7'
    )
    
    & btpair -u -b $ControllerMacAddress
}