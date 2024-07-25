#!/usr/bin/env bash
# ---------------------------------------------
# MACOS (DARWIN) Application Installs and Configs
# ---------------------------------------------

# Check if on the proper OS, and skip if not
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




# ---------------------------------------------
# CLI APPS: Default Install
# ---------------------------------------------
# vim, tldr, 1pw-cli, vd, bat
# fd, fzf, ripgrep

# if [ -f "$HOME/.Brewfile" ]; then
# echo "Updating homebrew bundle"
# brew bundle --global
# fi

# ---------------------------------------------
# GUI APPS: Default Install
# ---------------------------------------------
# chrome, 1pw, vscode, slack, zoom, iterm



# ---------------------------------------------
# APPS CONFIG:
# ---------------------------------------------

# # iTerm2 - Setup Preferences, Colors, and Fonts
# # TODO: include the colorscheme and font needed
# # Specify the preferences directory & use the custom preferences in the directory
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.config/iterm2-cfg"
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

