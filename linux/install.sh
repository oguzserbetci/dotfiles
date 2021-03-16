#!/usr/bin/env bash

# Fail fast
set -eu

# Get current dir (so run this script from anywhere)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Bunch of symlinks
ln -sf $DOTFILES_DIR/config/* $HOME/.config/
ln -sf $DOTFILES_DIR/linux/config/* $HOME/.config/

ln -sf $DOTFILES_DIR/proselintrc $HOME/.proselintrc
ln -sf $DOTFILES_DIR/latexmkrc $HOME/.latexmkrc
ln -sf $DOTFILES_DIR/pylintrc $HOME/.pylintrc
ln -sf $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf

ln -sf $DOTFILES_DIR/alias $HOME/.alias
ln -sf $DOTFILES_DIR/profile $HOME/.profile

mkdir -p $HOME/.local/bin
ln -sf $DOTFILES_DIR/bin/* $HOME/.local/bin
