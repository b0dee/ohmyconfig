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

