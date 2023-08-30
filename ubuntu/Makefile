# zsh is a shell designed for interactive use, although it is also a powerful scripting language.
zsh:
	bash scripts/install-zsh.sh

ohmyzsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#zinit is plugin manager for zsh
zinit:
	bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	zinit self-update

# nvm is a version manager for node.js, designed to be installed per-user, and invoked per-shell.
nvm:
	bash scripts/install-nvm.sh
