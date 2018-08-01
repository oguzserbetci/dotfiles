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

if [ ${SHELL: -4} != "fish" ]
then
  dscl . -read /Users/$USER UserShell
  sudo sh -c "echo $(which fish) >> /etc/shells"
  chsh -s $(which fish)
  tic "$DOTFILES_DIR/xterm-256color-italic.terminfo"
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fi

echo 'backend:TkAgg' >> ~/.matplotlib/matplotlibrc

# Bunch of symlinks
mkdir $HOME/.config
ln -sivf $DOTFILES_DIR/vim $HOME/.config/nvim
ln -sivf $DOTFILES_DIR/emacs.d $HOME/.emacs.d
ln -sivf $DOTFILES_DIR/bin $HOME/.bin
ln -sivf $DOTFILES_DIR/git $HOME/.config
ln -sivf $DOTFILES_DIR/config.fish $HOME/.config/fish
ln -sivf $DOTFILES_DIR/zshrc $HOME/.zshrc
ln -sivf $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf

ln -sivf $DOTFILES_DIR/khdrc $HOME/.khdrc
ln -sivf $DOTFILES_DIR/chumkwmrc $HOME/.chunkwmrc

ln -sivf $DOTFILES_DIR/ctags $HOME/.ctags
ln -sivf $DOTFILES_DIR/alias $HOME/.alias
ln -sivf $DOTFILES_DIR/flake8 $HOME/.config/flake8
ln -sivf $DOTFILES_DIR/functions $HOME/.functions
ln -sivf $DOTFILES_DIR/gitconfig $HOME/.gitconfig
ln -sivf $DOTFILES_DIR/gitignore $HOME/.gitignore
