# PowerShell Setup Guide

## Profile Setup

- Copy `Microsoft.PowerShell_profile.ps1` to `C:\Users\<UserName>\Documents\PowerShell\`.
- Update the line `"<PathToRepo>\PowerShellScripts\MyPowerShellModule.psm1"` to point to this repo.
- Comment out the reference to oh-my-posh until the next section is complete.

## Terminal Styling with oh-my-posh

Refer to [this page](https://ohmyposh.dev/docs/installation/windows) for up-to-date info on the installation process. As of writing, the installation process is as follows:

- Install oh-my-posh:
```
winget install JanDeDobbeleer.OhMyPosh -s winget
```
- Close the terminal to add oh-my-posh to  PATH.
- Open terminal as admin.
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
- Copy `my-theme.omp.json` to `C:\Users\<UserName>\AppData\Local\Programs\oh-my-posh\themes\`
- Uncomment the reference to oh-my-posh from `Microsoft.PowerShell_profile.ps1`.
- Restart terminal.