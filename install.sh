#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Bunch of symlinks
ln -sfv "$DOTFILES_DIR/.zshrc" ~
ln -sfv "$DOTFILES_DIR/.kwm" ~
ln -sfv "$DOTFILES_DIR/.khdrc" ~
ln -sfv "$DOTFILES_DIR/.functions" ~
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.gitignore" ~
ln -sfv "$DOTFILES_DIR/.zsh_history" ~

# Package managers & packages
echo "› brew bundle"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi
brew bundle

brew services start koekeishiya/khd/khd
brew services start koekeishiya/kwm/kwm

chsh -s /usr/local/bin/zsh-5.2

rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
ln -sfv ~/Dropbox/Sublime/Packages ~/Library/Application\ Support/Sublime\ Text\ 3/

. "$DOTFILES_DIR/osxdefaults.sh"

git clone git://github.com/amix/vimrc.git ~/.dotfiles/.vim_runtime
sh ~/.dotfiles/.vim_runtime/install_awesome_vimrc.sh

ln -sfv "$DOTFILES_DIR/.vim_runtime" ~
