#!/bin/bash

plugins_config="
zinit wait lucid light-mode for atinit'zicompinit; zicdreplay'
zdharma-continuum/fast-syntax-highlighting
atload'_zsh_autosuggest_start'
zsh-users/zsh-autosuggestions
blockf atpull'zinit creinstall -q .'
zsh-users/zsh-completions
"

# Append plugins configuration to ~/.zshrc
echo "$plugins_config" >> ~/.zshrc

echo "Plugins have been appended to ~/.zshrc"
