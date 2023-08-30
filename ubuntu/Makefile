REMOTE_USERNAME = 'joaobispo2077'
REMOTE_EMAIL = 'joaobispo2077@gmail.com'

# zsh is a shell designed for interactive use, although it is also a powerful scripting language.
zsh:
	bash scripts/install-zsh.sh

ohmyzsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#p10k is a lightweight theme for Zsh. It emphasizes speed, flexibility and out-of-the-box experience.
p10k:
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	p10k configure

#zinit is plugin manager for oh my zsh
zinit:
	bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	zinit self-update

# nvm is a version manager for node.js, designed to be installed per-user, and invoked per-shell.
nvm:
	bash scripts/install-nvm.sh

init_git:
	@echo "Config git username"
	@echo
	git config user.name $(REMOTE_USERNAME)
	@echo "Config git email"
	@echo
	git config user.email $(REMOTE_EMAIL)
	@echo Usando username:
	git config --get user.name
	@echo Usando email:
	git config --get user.email