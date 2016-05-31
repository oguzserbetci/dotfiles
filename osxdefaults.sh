defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write -g QLPanelAnimationDuration -float 0.15
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15

killall Dock
