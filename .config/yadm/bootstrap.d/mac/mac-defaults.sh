#!/usr/bin/env bash
# ---------------------------------------------
# MACOS (DARWIN) Defaults
# This file uses the defaults command to setup initial preferences
# ---------------------------------------------

# Check if on the proper OS, and skip if not
export OS_TYPE="$(uname -s)"
if [[ "$OS_TYPE" != "Darwin" ]]; then echo "Skipping ${0} ..."; exit 0; fi
echo "Running ${OS_TYPE} Bootstrap... ${0}"

# Beginning Installation
echo ""
echo "-------------------------------------------------------"
echo "Starting DEFAULTS install for (${OS_TYPE})"
echo "-------------------------------------------------------"


# Calendar - Set defaults
defaults write com.apple.iCal "first day of week" -int 2 # set monday to be first day of the week

# Display - Set Defaults
defaults write com.apple.dock wvous-bl-corner -int 3 # set bottom-left to application-windows
defaults write com.apple.dock wvous-bl-modifier -int 0 # set modifier to null
defaults write com.apple.dock wvous-br-corner -int 0 # set bottom-right no action
defaults write com.apple.dock wvous-br-modifier -int 0 # set modifier to null
defaults write com.apple.dock wvous-tl-corner -int 2 # set top-left to mission-control
defaults write com.apple.dock wvous-tl-modifier -int 0 # set modifier to null
defaults write com.apple.dock wvous-tr-corner -int 4 # set top-right to desktop
defaults write com.apple.dock wvous-tr-modifier -int 0 # set modifier to null

# Dock - Set defaults
defaults write com.apple.dock orientation -string left # put dock on left side

# Keyboard - Set defaults
defaults write -g InitialKeyRepeat -int 15 # set keyboard initial delay
defaults write -g KeyRepeat -int 1 # set keyboard repeat rate
defaults write -g com.apple.keyboard.fnState -bool true # enable function keys
defaults write -g ApplePressAndHoldEnabled -bool false # disable keyboard accents

# Finder - Set defaults
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # show all filename extensions
defaults write com.apple.Finder FXPreferredViewStyle clmv # default to column view
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # search from active folder
defaults write com.apple.finder NewWindowTarget -string "PfDe" # set default window to desktop
defaults write com.apple.finder ShowPathbar -bool true # show the pathbar
defaults write com.apple.finder ShowStatusBar -bool true # show status bar
defaults write com.apple.finder _FXSortFoldersFirst -bool true # keep folders on top in finder
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true # keep folders on top on desktop
defaults write com.apple.sidebarlists systemitems -dict-add ShowHome -bool true # Show home in sidebar

# Misc - Set defaults
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool true # enable trackpad pinch

# Safari - Set defaults
# defaults write com.apple.Safari AutoOpenSafeDownloads -bool false # do not auto open downloads
# defaults write com.apple.Safari DownloadsPath -string "$HOME/Desktop" # change download folder


