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
dirs=("bin" "tmp" "dev") # Use an array for better readability

for dir in "${dirs[@]}"; do # Properly iterate array elements
  dir_path="${HOME}/${dir}" # Construct the full path once
  if [[ ! -d "$dir_path" ]]; then # Quote the path variable for safety and use a more descriptive if condition
    mkdir -p "$dir_path" # use -p to make parent directories if they don't exist
    echo "Created $dir_path"
  else
      echo "Directory $dir_path already exists"
  fi
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

