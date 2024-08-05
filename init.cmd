@echo off

set ohmydir=%~dp0..\

echo [+] Symlinking config files 
forfiles /p "%ohmydir%common" /c "cmd /c mklink /h %userprofile%\@file @path"
forfiles /p "%ohmydir%windows" /c "cmd /c mklink /h %userprofile%\@file @path"

echo [+] Generating SSH keys
ssh-keygen -q -N "" -t ed25519 -f %userprofile%\.ssh\id_ed25519-github

echo [+] Public key data:
type %userprofile%\.ssh\id_ed25519-github

echo [+] Setting Git username
git config --global user.name "Joe Paterson"

echo [+] Setting Git email
git config --global user.email "1@1.com"

echo [+] Setting Git to automatically create remotes to track when pushing a branch
git config --global --add --bool push.autoSetupRemote true
