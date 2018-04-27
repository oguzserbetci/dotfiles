#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOTFILES_DIR

# Package managers & packages
echo "› brew bundle"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
else
    brew update
fi

brew bundle

if [ "$(uname 2> /dev/null)" != "Linux" ]; then
  brew services start khd
  brew services start chunkwm
  sh $DOTFILES_DIR/osxdefaults.sh
fi

if [ ${SHELL: -3} != "zsh" ]
then
  dscl . -read /Users/$USER UserShell
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  chsh -s $(which zsh)
  tic "$DOTFILES_DIR/xterm-256color-italic.terminfo"
fi

# Bunch of symlinks
mkdir "$HOME/.config"
ln -siv "$DOTFILES_DIR/vim" "$HOME/.config/nvim"
ln -siv "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
ln -siv "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"

ln -siv "$DOTFILES_DIR/khdrc" "$HOME/.khdrc"
ln -siv "$DOTFILES_DIR/chumkwmrc" "$HOME/.chunkwmrc"

ln -siv "$DOTFILES_DIR/ctags" "$HOME/.ctags"
ln -siv "$DOTFILES_DIR/alias" "$HOME/.alias"
ln -siv "$DOTFILES_DIR/flake8" "$HOME/.config/flake8"
ln -siv "$DOTFILES_DIR/functions" "$HOME/.functions"
ln -siv "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
ln -siv "$DOTFILES_DIR/gitignore" "$HOME/.gitignore"
