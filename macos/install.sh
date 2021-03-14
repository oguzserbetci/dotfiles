#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
export DOTFILES_DIR

# Fail fast
set -eu

# Bunch of symlinks
mkdir -p $HOME/.config
ln -sf $DOTFILES_DIR/config/* $HOME/.config/
ln -sf $DOTFILES_DIR/bin $HOME/.bin

ln -sf $DOTFILES_DIR/skhdrc $HOME/.skhdrc
ln -sf $DOTFILES_DIR/yabairc $HOME/.yabairc

ln -sf $DOTFILES_DIR/proselintrc $HOME/.proselintrc
ln -sf $DOTFILES_DIR/pylintrc $HOME/.pylintrc

ln -sf $DOTFILES_DIR/alias $HOME/.alias
ln -sf $DOTFILES_DIR/functions $HOME/.functions
ln -sf $DOTFILES_DIR/profile $HOME/.profile
ln -sf $DOTFILES_DIR/ctags.d $HOME/.ctags.d
ln -sf $DOTFILES_DIR/condarc $HOME/.condarc
ln -sf $DOTFILES_DIR/gitconfig $HOME/.gitconfig

# Brew
if [ "$(uname 2>/dev/null)" != "Linux" ]; then

	# Package managers & packages
	echo "› brew bundle"
	which -s brew
	if [[ $? != 0 ]]; then
		# Install Homebrew
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	else
		brew update && brew upgrade
		brew bundle
	fi

	pipx ensurepath
	pipx completions
	pipx install pygments

	brew services start skhd
	brew services start yabai

	# For better git diff
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	cargo install git-delta

	npm install --global stylelint js-beautify shellcheck pyright
fi

# Fish Shell
if [ ${SHELL: -4} != "fish" ]; then
	dscl . -read /Users/$USER UserShell
	sudo sh -c "echo $(which fish) >> /etc/shells"
	chsh -s $(which fish)
	curl -Lo $HOME/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

	fisher install jethrokuan/z matchai/spacefish jethrokuan/fzf fisherman/grc danhper/fish-ssh-agent goranmoomin/fish-rustup
fi

# Emacs Doom
if [ -e "$HOME/.config/emacs/bin/doom" ]; then
	echo "DOOM is already installed"
else
	rm -fr $HOME/.config/emacs
	git clone https://github.com/hlissner/doom-emacs.git $HOME/.config/emacs
	(
		cd $HOME/.config/emacs
		git checkout develop
		git pull
		./bin/doom install
	)
	ln -sf $HOME/.config/emacs/bin/* $HOME/.bin/
fi

# Development
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
npm install -g pyright
npm install --global prettier @prettier/plugin-php prettier-plugin-solidity

echo 'setup python: https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14 and install virtual fish: pip install virtualfish'

curl -s https://api.github.com/repos/retorquere/zotero-better-bibtex/releases/latest | jq -r '.assets[].browser_download_url' | wget -i - -P $HOME/Downloads
curl -s https://api.github.com/repos/jlegewie/zotfile/releases/latest | jq -r '.assets[].browser_download_url' | wget -i - -P $HOME/Downloads
curl -s https://api.github.com/repos/wshanks/Zutilo/releases/latest | jq -r '.assets[].browser_download_url' | wget -i - -P $HOME/Downloads
wget -i http://jpetrie.net/wp-content/uploads/custom_scientific_US.dic -P misc

# sh $DOTFILES_DIR/macosdefaults.sh
