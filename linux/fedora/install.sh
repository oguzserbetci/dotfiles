#!/usr/bin/env bash

# Fail fast
set -eu

sudo dnf copr -y enable deathwish/emacs-pgtk-nativecomp
sudo dnf install -y emacs

# Package managers & packages
if [ ${SHELL: -4} != "fish" ]
then
  sudo dnf install -y fish util-linux-user
  chsh -s /usr/bin/fish
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  fisher install jethrokuan/z matchai/spacefish jethrokuan/fzf fisherman/grc danhper/fish-ssh-agent goranmoomin/fish-rustup
  curl -fsSL https://starship.rs/install.sh | bash
fi

rm -fr $HOME/.config/emacs
git clone https://github.com/hlissner/doom-emacs.git $HOME/.config/emacs
(
  cd $HOME/.config/emacs
  git checkout develop
  git pull
  ./bin/doom install
  mkdir -p $HOME/.local/bin
  ln -sf $HOME/.config/emacs/bin/* $HOME/.local/bin
)

sudo dnf install -y kitty
ln -sf $HOME/.dotfiles/config/kitty $HOME/.config
