#!/bin/bash

# Create cloud-init configuration file
sudo tee /etc/cloud/cloud.cfg.d/99-custom.cfg > /dev/null <<EOL
#cloud-config
packages:
  - pipx
  - pdm
  - lsd
  - powerline-gitstatus
users:
  - default
EOL

# Run cloud-init to apply the configuration
sudo cloud-init init
sudo cloud-init modules --mode=config
sudo cloud-init modules --mode=final

# Configure aliases
echo 'alias ll="lsd -l"' >> ~/.bashrc
echo 'alias la="lsd -a"' >> ~/.bashrc
echo 'alias gs="git status"' >> ~/.bashrc
echo 'alias gp="git pull"' >> ~/.bashrc
echo 'alias gpom="git push origin master"' >> ~/.bashrc

# Configure PATH to include Python bin
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
