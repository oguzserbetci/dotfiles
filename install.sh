#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOTFILES_DIR

# Bunch of symlinks
ln -sfv $DOTFILES_DIR/vim ~/.vim
ln -sfv $DOTFILES_DIR/vimrc ~/.vimrc
ln -sfv $DOTFILES_DIR/zshrc ~/.zshrc
ln -sfv $DOTFILES_DIR/tmux.conf ~/.tmux.conf

ln -sfv $DOTFILES_DIR/khd ~/.khd
ln -sfv $DOTFILES_DIR/chumkwmrc ~/.chunkwmrc

ln -sfv $DOTFILES_DIR/ctags ~/.ctags
ln -sfv $DOTFILES_DIR/alias ~/.alias
ln -sfv $DOTFILES_DIR/flake8 ~/.config
ln -sfv $DOTFILES_DIR/functions ~/.functions
ln -sfv $DOTFILES_DIR/gitconfig ~/.gitconfig
ln -sfv $DOTFILES_DIR/gitignore ~/.gitignore

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

if [ "$(uname 2> /dev/null)" != "Linux" ]; then
  brew services start koekeishiya/khd/khd
  brew services start koekeishiya/kwm/kwm
  . "$DOTFILES_DIR/osxdefaults.sh"
fi

if [ ${SHELL: -3} != "zsh" ]
then
  dscl . -read /Users/$USER UserShell
  chsh -s $(which zsh)
fi

sh python_setup.sh
