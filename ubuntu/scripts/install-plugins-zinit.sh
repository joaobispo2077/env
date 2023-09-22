#!/bin/bash

plugins_config=(
"zinit wait lucid light-mode for"
"  atinit'zicompinit; zicdreplay'"
"  zdharma-continuum/fast-syntax-highlighting"
"  atload'_zsh_autosuggest_start'"
"  zsh-users/zsh-autosuggestions"
"  blockf atpull'zinit creinstall -q .'"
"  zsh-users/zsh-completions"
)

# Join the array elements into a single string
plugins_config_string=$(printf "%s\n" "${plugins_config[@]}")

# Append plugins configuration to ~/.zshrc
echo "$plugins_config_string" >> ~/.zshrc

echo "Plugins have been appended to ~/.zshrc"
