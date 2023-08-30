#!/bin/bash

# Update package information
sudo apt update

# Install Node Version Manager (NVM)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

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
