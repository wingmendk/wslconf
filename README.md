# WSL2 Quick Configuration Guide # 

## 1. Run the Windows Configuration script ##

Use the one-liner below in an Admin PowerShell instance.  
- Run the `Make Me Admin` app and click `Grant Me Administrator Rights`
- Press `Windows + X`
- Click `Terminal (Admin)`

You can now run this script:

```ps
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://github.com/wingmendk/wslconf/blob/main/install.ps1')
```

The script does the following:
1. Downloads and installs Cascadia Code NF font family - you will need this to ensure
that special characters are rendered correctly in VS Code and Terminal.
2. Installs Windows Terminal - a superior and flexible terminal experience
3. Configure WSL - Windows Subsystem for Linux is required to run Ubuntu on Windows. The dependencies will be added to windows automatically. Your PC may have to restart.
4. Download Ubuntu 24.04 from the Microsoft Store - your dev environment will be on a linux instance and the latest LTS release of Ubuntu has the tools you neeed.
5. Run Ubuntu installation - you will be asked for username and password. Don't forget!

## 2. Ubuntu 24.04 configuration for Wingmen WSL2 installation ##

Use the one-liner below in Ubuntu24.04 to configure and pre-install required packages to get you off the ground!

However, there is a few short steps before, so let us configure Terminal first to ensure a good experience.

- Open `Windows Terminal`.
- Click `Ctrl + ,` to open settings.
- Select a default profile: `Ubuntu 24.04`.
- Ensure that your default terminal app is `Windows Terminal` and save.
- In the left menu click `Defaults`.
- Make your changes to your own desire but ensure that `Font face` is set to `Cascadia Code NF`.


NOW you are finally ready to run the script. 

Click the down arrow in the top of the terminal and select `Ubuntu 24.04`. This will open a prompt.

Run this command:

```bash
curl -sSL https://github.com/wingmendk/wslconf/blob/main/wslconf.sh | bash
```

The script does the following:
1. Updates packages
2. Install lsd, powerline-gitstatus, python, pipx, git, wget, pdm, ipython, cookiecutter
3. Add aliases to lsd instead of ls
4. Ensure python binaries on path
5. Enables powerlines

## 3. Install VS Code and Extensions ##

1. Download VS Code and install it: [VS Code](https://code.visualstudio.com/Download)
2. Click the link and install this extension: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
2. Open a new Ubuntu 24.04 Terminal and run these commands:
```bash
mkdir hello
cd hello
pdm venv create
echo 'print("hello, world")' > hello.py
code .
```
This will create a Python virtual developer environment in the folder hello.
It will also create a basic hello world Python script.
The final line will trigger an install of the code remote development server, and open VS Code.

3. Click on hello.py
4. VS Code will ask to install Python language server. Do it!
5. Run your file with the play button.

### You're done! Congrats! ### 
