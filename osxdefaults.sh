#!/usr/bin/env bash
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
defaults write -g ApplePressAndHoldEnabled -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Speed up Mission Control animations
# defaults write com.apple.dock expose-animation-duration -float 0.1
# defaults write -g QLPanelAnimationDuration -float 0.1
# defaults write com.apple.dock autohide-delay -float 0
# defaults write com.apple.dock autohide-time-modifier -float 0.15

# defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

# MAIL
# defaults write com.apple.mail DisableSendAnimation -bool true
# defaults write com.apple.mail DisableReplyAnimations -bool true

#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

# disable app nap for emacs
defaults write org.gnu.Emacs NSAppSleepDisabled -bool YES

killall Dock
