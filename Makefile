setup-zsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	source ~/.zshrc
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	source ~/.zshrc

setup-other-stuff:
	# better cd
	brew install zoxide
	# better ls
	brew install eza
	# TUI delimited data
	cargo install tabiew
	# TUI search/replace
	cargo install serpl

setup-tmux:
	brew install tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

setup-nvim:
	brew tap homebrew/cask-fonts
	brew install font-blex-mono-nerd-font
	brew install neovim
	brew install ripgrep
	brew install node
	brew install fzf

setup-python:
	# install poetry venv in this repo
	# update init.lua with path of that venv
	brew install fd
	# open python file, <Leader>vs, select environment

setup-dotfiles:
	brew install stow
	# remove old dotfiles 
	stow .  # in dev-configs repo root level AND when files need to be refreshed

setup-git:
	git config --global core.editor "neovim"
