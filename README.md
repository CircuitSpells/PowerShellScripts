# PowerShellScripts

## Requirements

This repo requires Windows and PowerShell 7 (to check your PowerShell version, open a PowerShell window and run `$PSVersionTable`).

PowerShell 7 will have ideally  been installed using winget, however that is not necessary unless you'd like to use the `Update-PowerShell` cmdlet. If you have installed PowerShell 7 through other means, you can safely uninstall, then reinstall using the provided `Install-PowerShell` cmdlet.

 To install PowerShell 7, clone this repo, open a PowerShell instance *as an admin*, navigate to this repo's [cmdlets](/cmdlets/) directory, and then run the following:
```PowerShell
Import-Module .\Install-PowerShell.ps1
```

Then run:
```PowerShell
Install-PowerShell
```

## Setup Guide

### PowerShell Profile

All cmdlets in this repo's [cmdlets](/cmdlets/) directory can be automatically imported into PowerShell each time a new PowerShell window is opened. This allows for instant access to those cmdlets without having to explicitly import modules or type out long paths to a script.

To automatically import cmdlets:

- Copy [Microsoft.PowerShell_profile.ps1](profile/Microsoft.PowerShell_profile.ps1) to `C:\Users\<UserName>\Documents\PowerShell\`.
- Open the copied `Microsoft.PowerShell_profile.ps1` file and update `$PathToRepo` to point to this repo's path.
- Update `<username>` with your Windows username.
- Comment out the line referencing `oh-my-posh` until the next section is complete.

### A Not-So-Ugly Terminal

Install Windows Terminal from the Microsoft Store (Terminal comes automatically with Windows 11). Once installed, open Terminal and Navigate to the settings page with `Ctrl + ,`, then set "Default profile" to "PowerShell" (not to be confused with "Windows PowerShell", which is PowerShell 5).

The terminal is ugly by default, and can be upgraded with oh-my-posh (if needed, refer to [this page](https://ohmyposh.dev/docs/installation/windows) for up-to-date info on the installation process).

As of writing, the installation process is as follows:

- Install oh-my-posh:
```
winget install JanDeDobbeleer.OhMyPosh -s winget
```
- Close the terminal to add `oh-my-posh` to your system PATH.
- Open Terminal as admin.
- Install custom fonts with the following command:
```
oh-my-posh font install
```
- Scroll down and select "Meslo".
- Enter `Ctrl + Shift + ,` to edit the Terminal settings.json file.
- Add the `font.face` attribute to the `defaults` attribute:
```json
{
    "profiles":
    {
        "defaults":
        {
            "font": 
            {
                "face": "MesloLGM Nerd Font"
            }
        }
    }
}
```
- Copy [my-theme.omp.json](profile/my-theme.omp.json) to `C:\Users\<UserName>\AppData\Local\Programs\oh-my-posh\themes\`.
- Uncomment the reference to `oh-my-posh` from `C:\Users\<UserName>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`.
- Restart Terminal.