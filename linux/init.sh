echo Setting Git username
git config --global user.name "Joe Paterson"

echo Setting Git email
git config --global user.email "1@1.com"

echo Setting Git to automatically create remotes to track when pushing a branch
git config --global -add --bool push.autoSetupRemote true
