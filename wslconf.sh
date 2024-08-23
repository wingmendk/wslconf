#!/bin/bash
# Upgrade packages to the lastest version
sudo apt update && sudo apt upgrade -y
# install helpful packages
sudo apt install  -y pipx lsd powerline-gitstatus python3 python-is-python3 git wget curl
# install powershell reqs
sudo apt-get install -y wget apt-transport-https software-properties-common

echo >> ~/.bashrc
echo '# Configure custom aliases' >> ~/.bashrc
echo 'alias ls="lsd -A --group-dirs first -1"' >> ~/.bashrc
echo 'alias la="lsd -A"' >> ~/.bashrc
echo 'alias l="lsd --group-dirs first -1"' >> ~/.bashrc
echo 'alias gs="git status"' >> ~/.bashrc
echo 'alias gp="git pull"' >> ~/.bashrc
echo 'alias gpom="git push origin master"' >> ~/.bashrc

echo >> ~/.bashrc
echo '# Configure PATH to include Python bin' >> ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

echo >> ~/.bashrc
echo "# Activate powerline if installed" >> ~/.bashrc
echo 'if command -v powerline-daemon &> /dev/null; then' >> ~/.bashrc
echo '    powerline-daemon -q' >> ~/.bashrc
echo '    POWERLINE_BASH_CONTINUATION=1' >> ~/.bashrc
echo '    POWERLINE_BASH_SELECT=1' >> ~/.bashrc
echo '    . /usr/share/powerline/bindings/bash/powerline.sh' >> ~/.bashrc
echo 'fi' >> ~/.bashrc 

# Touch .hushlogin to suppress login message
touch ~/.hushlogin

# Use pipx to install pdm and inject cookiecutter
source ~/.bashrc && pipx install pdm
source ~/.bashrc && pipx inject pdm cookiecutter

# Use pipx to install ipython and inject requests
source ~/.bashrc && pipx install ipython
source ~/.bashrc && pipx inject ipython requests netmiko

# cookiecutter
source ~/.bashrc && pipx install cookiecutter

echo "Configuration complete."
echo "if you do not have an ssh key generated please run:"
echo "  ssh-keygen"
echo 
