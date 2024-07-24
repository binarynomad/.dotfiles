#!/bin/sh

# Start the Brew Installer which will also install Xcode/git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Temporarily envoke the brew environment, this will be replaced
# by the YADM entry in .zprofile
eval "$(/opt/homebrew/bin/brew shellenve)"

# Use Brew to install YADM
brew install yadm

# Use YADM to pull the rest of the ENV and Bootstrap files
yadm clone https://github.com/binarynomad/.dotfiles.git

