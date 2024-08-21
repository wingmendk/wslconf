#!/bin/bash

sudo apt update
sudo apt install pipx lsd powerline-gitstatus python3 python-is-python3 git -y

echo '# Configure custom aliases' >> ~/.bashrc
echo 'alias ll="lsd -l"' >> ~/.bashrc
echo 'alias la="lsd -a"' >> ~/.bashrc
echo 'alias gs="git status"' >> ~/.bashrc
echo 'alias gp="git pull"' >> ~/.bashrc
echo 'alias gpom="git push origin master"' >> ~/.bashrc

echo '# Configure PATH to include Python bin' >> ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Activate powerline if installed
echo 'if command -v powerline-daemon &> /dev/null; then' >> ~/.bashrc
    echo 'powerline-daemon -q' >> ~/.bashrc
    echo 'POWERLINE_BASH_CONTINUATION=1' >> ~/.bashrc
    echo 'POWERLINE_BASH_SELECT=1' >> ~/.bashrc
    echo '. /usr/share/powerline/bindings/bash/powerline.sh' >> ~/.bashrc
echo 'fi' >> ~/.bashrc 

# Touch .hushlogin to suppress login messages
touch ~/.hushlogin

# Use pipx to install pdm and inject cookiecutter
pipx install pdm
pipx inject pdm cookiecutter

# Use pipx to install ipython and inject requests
pipx install ipython
pipx inject ipython requests

echo "Configuration complete."
echo "if you do not have an ssh key generated please run:"
echo "  ssh-keygen"
echo 
