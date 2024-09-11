#!/bin/bash

#### PACKAGE INSTALL ####
# Upgrade packages to the latest version
sudo apt update && sudo apt upgrade -y

# Install helpful packages
sudo apt install -y pipx lsd powerline-gitstatus python3 python-is-python3 git wget curl apt-transport-https software-properties-common

# Install Azure CLI (az)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Azure DevOps extension to az CLI
az extension add --name azure-devops

# Install uv and uvx
curl -LsSf https://astral.sh/uv/install.sh | sh


#### FILESYSTEM ####
# create a symlink for msedge to allow opening a browser from WSL2
ln -s "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" msedge.exe

# Touch .hushlogin to suppress login message
touch ~/.hushlogin


#### BASH PROFILE CONFIGURATION ####
# Use lsd instead of ls - set aliases
echo                                                            >> ~/.bashrc
echo '# Configure custom aliases'                               >> ~/.bashrc
echo 'alias ls="lsd -A --group-dirs first -1"'                  >> ~/.bashrc
echo 'alias la="lsd -A"'                                        >> ~/.bashrc
echo 'alias l="lsd --group-dirs first -1"'                      >> ~/.bashrc

# Make sure that Python is on PATH
echo                                                            >> ~/.bashrc
echo '# Configure PATH to include Python bin'                   >> ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"'                     >> ~/.bashrc

# Allow WSL2 to open a browser window in interactive login sessions
echo                                                            >> ~/.bashrc
echo "# set default browser"                                    >> ~/.bashrc
echo 'export BROWSER="$HOME/msedge.exe"'                        >> ~/.bashrc

# Conditionally enable powerlines - tracks git status in bash
echo                                                            >> ~/.bashrc
echo "# Activate powerline if installed"                        >> ~/.bashrc
echo 'if command -v powerline-daemon &> /dev/null; then'        >> ~/.bashrc
echo '    powerline-daemon -q'                                  >> ~/.bashrc
echo '    POWERLINE_BASH_CONTINUATION=1'                        >> ~/.bashrc
echo '    POWERLINE_BASH_SELECT=1'                              >> ~/.bashrc
echo '    . /usr/share/powerline/bindings/bash/powerline.sh'    >> ~/.bashrc
echo 'fi'                                                       >> ~/.bashrc 


#### LOGIN TO SERVICES ####
# login to az cli
source ~/.bashrc && az login

# Run ssh-keygen if SSH key not present
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "SSH key not found, generating a new one..."
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
else
    echo "SSH key already exists, skipping generation."
fi

# print ssh public key and ask to copy to clipboard
cat ~/.ssh/id_rsa
echo
echo "COPY THE PUBLIC KEY ABOVE!"
echo "Press any key to open Azure DevOps SSH Keys manager"
while true; do
    read -t 3 -n 1
    if [ $? = 0 ]; then
        echo "Opening Azure DevOps SSH Keys manager..."
        # Open the ssh-key add wizard on Azure DevOps
        source ~/.bashrc && $HOME/msedge.exe "https://dev.azure.com/wingmen/_usersSettings/keys"
        # FINAL MESSAGE
        echo  
        echo "Completed. Restart this session to reload your profile or write this in the terminal:"
        echo "  source ~/.bashrc"
        break
    fi
done
#EOF