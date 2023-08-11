# Add node.js versions with LTS
nvm version
nvm on
nvm list
nvm install 14
nvm install 16
nvm install lts

# Refresh environment variables from PATH
refreshenv
node -v


# Add python LTS
pyenv install -list
pyenv install 3.10.0
pyenv versions
pyenv global 3.10.0

# Refresh environment variables from PATH
refreshenv

python -V

# Refresh environment variables from PATH
refreshenv

# Add vscode as git config editor
git config --global core.editor code

# Add git aliases
git config --global alias.s '!git status -s'
git config --global alias.c '!git add --all && git commit -m'
git config --global alias.l "!git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'"
