#!/bin/bash

# Variables
apps="vim \
      git  \
      tmux \
      curl \
      wget \
      nmap \
      zsh  \
"

# Setup
echo [+] Symlinking config files
OHMY_DIR=$( dirname $(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ))
find $OHMY_DIR/common $OHMY_DIR/linux -exec ln -s {} ~/ \;

echo [+] Updating and Upgrading apt repositories
sudo apt update -y  && sudo apt dist-upgrade -y 

echo [+] Installing Apps: ${apps}
sudo apt install ${apps}

echo [+] Installing Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo [+] Generating SSH keys
ssh-keygen -q -N "" -t ed25519 -f ~/.ssh/id_ed25519-github

echo [+] Public key data:
cat ~/.ssh/id_ed25519-github

read -p "Copy the above public key into your GitHub SSH keys and press any key to continue... " -n1 -s

[[ -d ~/repos ]] || echo [+] Creating repo folder && mkdir ~/repos

[[ -d ~/repos/ohmyconfig ]] || echo [+] Cloning b0dee/ohmyconfig && git clone git@github.com:b0dee/ohmyconfig.git ~/repos/ohmyconfig

[[ -d ~/repos/vimwiki ]] || echo [+] Cloning b0dee/vimwiki && git clone git@github.com:b0dee/vimwiki.git ~/repos/vimiki 

[[ -d ~/vimwiki ]] || echo [+] Creating symlink in $HOME to ~/repos/vimwiki && ln -s ~/repos/vimwiki ~/vimwiki
