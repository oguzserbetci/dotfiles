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
  brew services start skhd
  brew services start yabai
  sh $DOTFILES_DIR/osxdefaults.sh
fi

if [ ${SHELL: -4} != "fish" ]
then
  dscl . -read /Users/$USER UserShell
  sudo sh -c "echo $(which fish) >> /etc/shells"
  chsh -s $(which fish)
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fi

# setup matplotlib
mkdir -p ~/.matplotlib
echo 'backend:TkAgg' >> ~/.matplotlib/matplotlibrc

# setup spacemacs
if test -f "~/.config/emacs/bin/doom";
then 
    echo "DOOM ALREADY INSTALLED"
else
    rm -fr ~/.config/emacs
    git clone https://github.com/hlissner/doom-emacs.git ~/.config/emacs
    (cd ~/.config/emacs; git checkout develop; git pull;./bin/doom install)
fi

# install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo 'run :PlugInstall in vim'

fisher add jethrokuan/z matchai/spacefish jethrokuan/fzf fisherman/grc

echo 'setup python: https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14 and install virtual fish: pip install virtualfish'
echo 'install zotero plugins at: http://zotfile.com/ http://retorque.re/zotero-better-bibtex/'

# Bunch of symlinks
mkdir -p ~/.config
ln -sf $DOTFILES_DIR/config/* ~/.config/
ln -sf $DOTFILES_DIR/bin ~/.bin
ln -sf $DOTFILES_DIR/zshrc ~/.zshrc
git clone --depth 1 git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
ln -sf ~/.config/kitty/kitty-themes/themes/Dracula.conf ~/.config/kitty/theme.conf

ln -sf $DOTFILES_DIR/skhdrc ~/.skhdrc
ln -sf $DOTFILES_DIR/yabairc ~/.yabairc

ln -sf $DOTFILES_DIR/proselintrc ~/.proselintrc
ln -sf $DOTFILES_DIR/pylintrc ~/.pylintrc

ln -sf $DOTFILES_DIR/alias ~/.alias
ln -sf $DOTFILES_DIR/functions ~/.functions
ln -sf $DOTFILES_DIR/profile ~/.profile
ln -svf $DOTFILES_DIR/ctags.d $HOME/.ctags.d

echo 'setup org notes by syncing dropbox and running ln -svf ~/Dropbox/org ~'
