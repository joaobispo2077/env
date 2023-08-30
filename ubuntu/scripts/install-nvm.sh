#!/bin/bash

# Update package information
sudo apt update

# Install Node Version Manager (NVM)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

nvm_config="
export NVM_DIR=\"\$HOME/.nvm\"
[ -s \"\$NVM_DIR/nvm.sh\" ] && \\. \"\$NVM_DIR/nvm.sh\"  # This loads nvm
[ -s \"\$NVM_DIR/bash_completion\" ] && \\. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion
"

# Append NVM configuration to ~/.zshrc
echo "$nvm_config" >> ~/.zshrc

echo "NVM configuration has been appended to ~/.zshrc"

# Load NVM into the current shell session
source ~/.nvm/nvm.sh

# Install LTS version of Node.js using NVM
nvm install --lts

# Set the installed LTS version as the default
nvm alias default 'lts/*'

# Print installed versions
echo "Git $(git --version)"
echo "NVM $(nvm --version)"
echo "Node.js $(node --version)"
echo "npm $(npm --version)"

source ~/.zshrc