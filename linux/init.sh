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

echo [+] Updating and Upgrading apt repositories
sudo apt update -y  && sudo apt dist-upgrade -y 

echo [+] Installing Apps: ${apps}
sudo apt install ${apps}

echo [+] Installing Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo [+] Setting Git username
git config --global user.name "Joe Paterson"

echo [+] Setting Git email
git config --global user.email "1@1.com"

echo [+] Setting Git to automatically create remotes to track when pushing a branch
git config --global -add --bool push.autoSetupRemote true

echo [+] Generating SSH keys
ssh-keygen -q -N "" -t ed25519 -f ~/.ssh/id_ed25519-github
echo [+] Created GitHub SSH key
echo [+] Public key data:
cat ~/.ssh/id_ed25519-github

