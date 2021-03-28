#!/usr/bin/env bash

# Fail fast
set -eu

# Get current dir (so run this script from anywhere)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"

echo $DOTFILES_DIR
#ln -si $DOTFILES_DIR/bin/* $HOME/.local/bin/

# Bunch of symlinks
ln -si $DOTFILES_DIR/config/* $HOME/.config/
# ln -si $DOTFILES_DIR/linux/config/* $HOME/.config/

ln -si $DOTFILES_DIR/proselintrc $HOME/.proselintrc
ln -si $DOTFILES_DIR/latexmkrc $HOME/.latexmkrc
ln -si $DOTFILES_DIR/pylintrc $HOME/.pylintrc
ln -si $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf

ln -si $DOTFILES_DIR/alias $HOME/.alias
ln -si $DOTFILES_DIR/profile $HOME/.profile

mkdir -p $HOME/.local/bin
ln -si $DOTFILES_DIR/bin/* $HOME/.local/bin/
