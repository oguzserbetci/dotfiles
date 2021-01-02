#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
export DOTFILES_DIR

# Fail fast
# set -Eeuo pipefail

# Bunch of symlinks
mkdir -p ~/.config
ln -sf $DOTFILES_DIR/config/* ~/.config/
ln -sf $DOTFILES_DIR/bin ~/.bin

ln -sf $DOTFILES_DIR/skhdrc ~/.skhdrc
ln -sf $DOTFILES_DIR/yabairc ~/.yabairc

ln -sf $DOTFILES_DIR/proselintrc ~/.proselintrc
ln -sf $DOTFILES_DIR/pylintrc ~/.pylintrc

ln -sf $DOTFILES_DIR/alias ~/.alias
ln -sf $DOTFILES_DIR/functions ~/.functions
ln -sf $DOTFILES_DIR/profile ~/.profile
ln -svf $DOTFILES_DIR/ctags.d $HOME/.ctags.d

# Brew
if [ "$(uname 2> /dev/null)" != "Linux" ]; then

  # Package managers & packages
  echo "› brew bundle"
  which -s brew
  if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    brew update && brew upgrade
    brew bundle
  fi

  pipx ensurepath
  pipx completions
  pipx install pygments

  brew services start skhd
  brew services start yabai
fi

# Fish Shell
if [ ${SHELL: -4} != "fish" ]
then
  dscl . -read /Users/$USER UserShell
  sudo sh -c "echo $(which fish) >> /etc/shells"
  chsh -s $(which fish)
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

  fisher add jethrokuan/z matchai/spacefish jethrokuan/fzf fisherman/grc
fi

# Emacs Doom
if [ -e "$HOME/.config/emacs/bin/doom" ]
then 
    echo "DOOM is already installed"
else
    rm -fr ~/.config/emacs
    git clone https://github.com/hlissner/doom-emacs.git ~/.config/emacs
    (cd ~/.config/emacs; git checkout develop; git pull;./bin/doom install)
fi

# Development
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
npm install -g pyright

echo 'setup python: https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14 and install virtual fish: pip install virtualfish'

curl -s https://api.github.com/repos/retorquere/zotero-better-bibtex/releases/latest | jq -r '.assets[].browser_download_url' | wget -i - -P $HOME/Downloads
curl -s https://api.github.com/repos/jlegewie/zotfile/releases/latest | jq -r '.assets[].browser_download_url' | wget -i - -P $HOME/Downloads

# sh $DOTFILES_DIR/macosdefaults.sh