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
  chsh -s $(which zsh)
fi

