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
  curl -Lo $HOME/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  fisher install jethrokuan/z jethrokuan/fzf fisherman/grc danhper/fish-ssh-agent
  curl -fsSL https://starship.rs/install.sh | bash
fi

mkdir -p $HOME/.local/bin
set -Up fish_user_paths /home/$USER/.local/bin

bash -c 'echo $PATH'

rm -fr $HOME/.config/emacs
git clone https://github.com/hlissner/doom-emacs.git $HOME/.config/emacs
(
  cd $HOME/.config/emacs
  git checkout develop
  git pull
  ./bin/doom install
  ln -sf $HOME/.config/emacs/bin/* $HOME/.local/bin
)

sudo dnf install -y kitty
ln -sf $HOME/.dotfiles/config/kitty $HOME/.config

sudo dnf install -y gnome-extensions-app gnome-tweaks gnome-shell-extension-appindicator

sudo dnf install -y  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-(rpm -E %fedora).noarch.rpm

sudo dnf upgrade --refresh
sudo dnf groupupdate core
sudo dnf install -y dnf-plugins-core

# Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update

# Pop shell
sudo dnf install -y gnome-shell-extension-pop-shell

# Fonts
sudo dnf install -y fira-code-fonts 'mozilla-fira*' 'google-roboto*'

# Vivaldi Browser
sudo dnf install -y dnf-utils
sudo dnf install -y vivaldi-stable

# improve browsing experience
sudo dnf install -y profile-sync-daemon
psd

nano /home/$USER/.config/psd/psd.conf
# Close your browser now
systemctl --user enable psd.service
systemctl --user start psd.service
systemctl --user status psd.service
psd preview

# NextCloud
sudo dnf install -y nextcloud-client nextcloud-client-nautilus

sudo -i
echo 'fs.inotify.max_user_watches = 524288' >> /etc/sysctl.conf
sysctl -p

sudo dnf install -y gcc gcc-g++ gfortran

# VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code

sudo dnf install -y texlive-scheme-full
sudo dnf install -y texstudio

sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

flatpak install -y zotero

flatpak install -y skype
flatpak install -y zoom
sudo dnf install -y vlc

sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y gstreamer1-plugin-openh264 mozilla-openh264

sudo dnf groups install "Development Tools"
sudo dnf install openssl-devel


# FONTS
sudo dnf copr enable peterwu/iosevka
sudo dnf install iosevka-aile-fonts iosevka-etoile-fonts
sudo dnf install iosevka-fonts iosevka-term-fonts iosevka-fixed-fonts
sudo dnf install 'iosevka-*ss05-fonts'

# NPM
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
# install doom emacs deps
npm i -g pyright markdown-preview js-beautify stylelint shellcheck
dnf install wl-clipboard

sudo dnf install editorconfig
sudo dnf install fzf
sudo dnf install aspell
sudo dnf install -y pipx
pipx install pytest
pipx install nose
pipx install black
pipx install isort
pipx install pyflakes
pipx install pycodestyle

# Python
sudo dnf install python3-devel
sudo

# Gnome extensions
# https://extensions.gnome.org/
# https://extensions.gnome.org/extension/15/alternatetab/
# https://extensions.gnome.org/extension/72/recent-items/
# https://extensions.gnome.org/extension/779/clipboard-indicator/

# Docker
# https://developer.fedoraproject.org/tools/docker/docker-installation.html
sudo dnf install -y pipx
pipx install docker-compose
usermod -aG docker $USER
