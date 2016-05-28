# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## BINARIES
binaries=(
  git
  caskroom/cask/brew-cask
  Caskroom/cask/xquartz
  libsvg
  curl
  libxml2
  gdal
  geos
  boost
)
apps=(
  java
  google-drive
  dropbox
  spotify
  sublime-text3
  virtualbox
  skype
  numi
  sketch
  anaconda2
  gitup
  appcleaner
  mactex
  font-fira-code
  iterm2
)

echo "installing binaries..."
brew install ${binaries[@]}

echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

## PYTHON
echo "installing python…"
brew install python3

## R
brew tap homebrew/science
brew install R

R CMD javareconf JAVA_CPPFLAGS=-I/System/Library/Frameworks/JavaVM.framework/Headers

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
