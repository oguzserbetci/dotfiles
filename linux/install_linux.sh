#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DOTFILES_DIR

# Package managers & packages
#if [ ${SHELL: -4} != "fish" ]
#then
#  pacman -S fish
#  dscl . -read /Users/$USER UserShell
#  sudo sh -c "echo $(which fish) >> /etc/shells"
#  chsh -s $(which fish)
#  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fi

# setup matplotlib
mkdir -p ~/.matplotlib
if ! test -f "~/.matplotlib";
then
  echo 'backend:TkAgg' >> ~/.matplotlib/matplotlibrc
fi

# setup spacemacs
if ! test -f "~/.emacs.d/bin/doom";
then
  pacman -S git tar clang emacs ripgrep fd
  rm -fr ~/.emacs.d
  git clone https://github.com/hlissner/doom-emacs.git ~/.emacs.d
  (cd ~/.emacs.d; git checkout develop; git pull;./bin/doom install)
fi

# setup yay for AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo 'run :PlugInstall in vim'

fisher add jethrokuan/z matchai/spacefish jethrokuan/fzf fisherman/grc

echo 'setup python: https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14 and install virtual fish: pip install virtualfish'
echo 'install zotero plugins at: http://zotfile.com/ http://retorque.re/zotero-better-bibtex/'

# Bunch of symlinks
# -r: relative
ln -sfr $DOTFILES_DIR/config/* $HOME/.config/
ln -sfr $DOTFILES_DIR/doom.d $HOME/.doom.d
ln -sfr $DOTFILES_DIR/bin $HOME/.bin
git clone --depth 1 git@github.com:dexpota/kitty-themes.git $HOME/.config/kitty/kitty-themes
ln -sfr $HOME/.config/kitty/kitty-themes/themes/Dracula.conf $HOME/.config/kitty/theme.conf
ln -sfr $DOTFILES_DIR/eslintrc.json $HOME/.eslintrc.json

ln -sfr $DOTFILES_DIR/latexmkrc $HOME/.latexmkrc
ln -sfr $DOTFILES_DIR/pylintrc $HOME/.pylintrc
ln -sfr $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf

ln -sfr $DOTFILES_DIR/alias $HOME/.alias
ln -sfr $DOTFILES_DIR/profile $HOME/.profile

ln -sfr $DOTFILES/ctags.d $HOME/.ctags.d

echo 'setup org notes by syncing dropbox and running ln -svf ~/Dropbox/org ~'
