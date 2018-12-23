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
ln -svf $DOTFILES_DIR/vim $HOME/.config/nvim
ln -svf $DOTFILES_DIR/emacs/.emacs.d $HOME/.emacs.d
ln -svf $DOTFILES_DIR/spacemacs $HOME/.spacemacs
ln -svf $DOTFILES_DIR/proselintrc $HOME/.proselintrc
ln -svf $DOTFILES_DIR/bin $HOME/.bin
ln -svf $DOTFILES_DIR/git $HOME/.config
ln -svf $DOTFILES_DIR/config.fish $HOME/.config/fish
ln -svf $DOTFILES_DIR/zshrc $HOME/.zshrc

ln -svf $DOTFILES_DIR/khdrc $HOME/.khdrc
ln -svf $DOTFILES_DIR/chumkwmrc $HOME/.chunkwmrc

ln -svf $DOTFILES_DIR/ctags $HOME/.ctags
ln -svf $DOTFILES_DIR/alias $HOME/.alias
ln -svf $DOTFILES_DIR/flake8 $HOME/.config/flake8
ln -svf $DOTFILES_DIR/functions $HOME/.functions
ln -svf $DOTFILES_DIR/gitconfig $HOME/.gitconfig
ln -svf $DOTFILES_DIR/gitignore $HOME/.gitignore

. setup_tmux.sh
