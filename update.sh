#!/usr/bin/env fish

echo 'start updating ...'

echo 'updating homebrew'
brew update
brew upgrade
brew cleanup

echo 'updating fish shell'
fisher
fish_update_completions

echo 'updating spacemacs'
(cd ~/.emacs.d; git pull --rebase)

exit 0
