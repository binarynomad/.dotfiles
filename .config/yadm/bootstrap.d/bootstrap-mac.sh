#!/usr/bin/env bash
# ---------------------------------------------
# MACOS (DARWIN) Application Installs and Configs
# ---------------------------------------------

# Check if on the proper OS, and skip if not
export OS_TYPE="$(uname -s)"
if [[ "$OS_TYPE" != "Darwin" ]]; then echo "Skipping Mac/Darwin scripts..."; exit 0; fi
echo "Running ${OS_TYPE} Bootstrap..."


# Beginning Installation
echo ""
echo "-------------------------------------------------------"
echo "Starting Bootstrap install for (${OS_TYPE})"
echo "-------------------------------------------------------"

# Installs via (brew, mas, direct)

# ---------------------------------------------
# OS DEFAULT SETTINGS
# ---------------------------------------------

# Setup some default directories
for dir in bin tmp dev ; do
    if [[! -d ${HOME}/$dir ]]; then mkdir ${HOME}/$dir; fi
    echo "Created ${HOME}/$dir"
done

# ---------------------------------------------
# Brew & Mas APPS: Default Install
# ---------------------------------------------

# if [ -f "$HOME/.Brewfile" ]; then
# echo "Updating homebrew bundle"
# brew bundle --global
# fi

# ---------------------------------------------
# Manual Install Apps
# ---------------------------------------------
# Use SetApp to install (Cleanshot, BoltAI, ...)


# ---------------------------------------------
# APPS CONFIG:
# ---------------------------------------------

# # iTerm2 - Setup Preferences, Colors, and Fonts
# # TODO: include the colorscheme and font needed
# # Specify the preferences directory & use the custom preferences in the directory
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm2-cfg"
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

