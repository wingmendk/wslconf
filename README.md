---
title: WSL Development Environment Guide
icon: material/microsoft-windows
---

## Run the Windows Configuration script

Use the one-liner below in an Admin PowerShell instance - do this:  

1. Run the `Make Me Admin` app and click `Grant Me Administrator Rights`  
2. Press `Windows + X`  
3. Click `Terminal (Admin)`  

```powershell title="Install Ubuntu 24.04, Windows Terminal and Cascadia Code NF"
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://dev.azure.com/wingmen/code-hanger/_apis/git/repositories/development-environment-wsl/items?scopePath=install.ps1&api-version=6.0')
```

!!! info "What this does:"
    1. Downloads and installs Cascadia Code NF font family - you will need this to ensure  
    that special characters are rendered correctly in VS Code and Terminal.  
    2. Installs Windows Terminal - a superior and flexible terminal experience  
    3. Configure WSL - Windows Subsystem for Linux is required to run Ubuntu on Windows. The dependencies will be added to windows automatically. Your PC may have to restart.  
    4. Download Ubuntu 24.04 from the Microsoft Store - your dev environment will be on a linux instance and the latest LTS release of Ubuntu has the tools you neeed.  
    5. Run Ubuntu installation - you will be asked for username and password. __Don't forget!__  
    6. Invokes the configuration script for Ubuntu 24.04 - this will install the necessary packages and configure your terminal.

## Ubuntu 24.04 configuration

The powershell script invokes Ubuntu24.04 to configure and pre-install required packages to get you off the ground!
However, there is a __few short steps after__, so let us configure Terminal to ensure a good experience.

- Open `Windows Terminal`.
- Click `Ctrl + ,` to open settings.
- Select a default profile: `Ubuntu 24.04`.
- Ensure that your default terminal app is `Windows Terminal` and save.
- In the left menu click `Defaults`.
- Make your changes to your own desire but ensure that `Font face` is set to `Cascadia Code NF`.

!!! info "What the wslconf script does:"
    1. Updates packages
    2. Install lsd, powerline-gitstatus, python, git, wget, and uv/uvx
    3. Add aliases to lsd instead of ls
    4. Ensure python binaries on path
    5. Enables powerlines
    6. Generates a new SSH key to add to Azure DevOps

With this out of the way, click the __:octicons-chevron-down-24:__ (down arrow) in the top of the terminal and select `Ubuntu 24.04`. This will open a prompt.
We are now ready to install VS Code and the necessary extensions.

## Install VS Code and Extensions

1. Download VS Code and install it: [VS Code](https://code.visualstudio.com/Download)
2. Click the link and install this extension: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
2. Open a new Ubuntu 24.04 Terminal and run these commands:
```bash title="Virtual Environment & VS Code"
mkdir hello
cd hello
uv init --app
uv run hello.py
code .
```

This will create a Python virtual developer environment in the folder hello.
It will also create a basic hello world Python script.
The final line will trigger an install of the code remote development server, and open VS Code in the `hello` folder.

3. Now, click on hello.py
4. VS Code will ask to install Python language server. Do it!
5. Run your file with the play button.

!!! alert "You're done! Congrats!"
    You now have a fully functional development environment with Ubuntu 24.04, Windows Terminal, Cascadia Code NF, and VS Code with Python support.  
    Enjoy coding! :tada: :rocket: :computer: :heart:
