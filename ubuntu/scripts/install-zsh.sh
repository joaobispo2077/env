#!/bin/bash

# Update package information
sudo apt update

# Install Zsh
sudo apt install zsh -y

# Change the default shell to Zsh for the current user
chsh -s $(which zsh)

# Print Zsh version
echo "Zsh $(zsh --version)"
echo $SHELL
echo "V $($SHELL --version)"
