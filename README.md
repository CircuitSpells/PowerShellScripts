# PowerShellScripts

Note: this repo has only been tested on Windows.

## Setup Guide

## Install PowerShell 7

This repo requires PowerShell 7 (check your PowerShell version with `$PSVersionTable`). To install PowerShell 7, clone this repo, open a PowerShell 5 terminal, navigate to this repo's [cmdlets](/cmdlets/) directory, and then run the following:

```PowerShell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Import-Module .\Install-PowerShell.ps1 -Force
Install-PowerShell
```

### Auto-Import Cmdlets

To automatically import this repo's cmdlets into each PowerShell session:

- Open your PowerShell profile with VS Code: `code $PROFILE`, or open it manually at `C:\Users\<username>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`.
- Copy the contents of this repo's [Microsoft.PowerShell_profile.ps1](profile/Microsoft.PowerShell_profile.ps1) file and paste it into your PowerShell profile.
- Update the `$Username` variable to your Windows username and `$PathToRepo` to point to this repo's path.
- Comment out the line starting with `oh-my-posh` until the next section is complete.
- In Windows search, open Powershell 7. This repo's cmdlets should now be automatically imported into your session. You can verify by running `mycmd` to see the list of available cmdlets and custom functions.

### A Not-So-Ugly Terminal

Install Windows Terminal if on Windows 10 or lower (Windows 11 comes with it pre-installed):

```PowerShell
Install-WindowsTerminal
```

Open Terminal, navigate to the settings page with `Ctrl + ,`, then set "Default profile" to "PowerShell" (not to be confused with "Windows PowerShell", which is PowerShell 5).

The terminal is ugly by default, and can be upgraded with oh-my-posh:

```PowerShell
Install-OhMyPosh
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
  "profiles": {
    "defaults": {
      "font": {
        "face": "MesloLGM Nerd Font"
      }
    }
  }
}
```

- Copy [my-theme.omp.json](profile/my-theme.omp.json) to `C:\Users\<UserName>\AppData\Local\Programs\oh-my-posh\themes\`.
- Uncomment the reference to `oh-my-posh` from `C:\Users\<UserName>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`.
- Restart the Terminal.
