#!/bin/bash

# Define the new ZSH_THEME value
new_theme='ZSH_THEME="powerlevel10k"'

# Check if ~/.zshrc exists
if [ -f ~/.zshrc ]; then
  # Use sed to replace the ZSH_THEME line with the new value
  sed -i 's/ZSH_THEME="robbyrussell"/'"$new_theme"'/g' ~/.zshrc

  echo "ZSH_THEME in ~/.zshrc updated to $new_theme"
else
  echo "~/.zshrc not found. Please make sure you have Zsh installed and configured."
fi
