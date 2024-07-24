#!/bin/sh

# Start the Brew Installer which will also install Xcode/git
echo "Installing Xcode, Git, & Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Temporarily envoke the brew environment, this will be replaced
# by the YADM entry in .zprofile
echo "Envoking BREW enviroment..."
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use Brew to install YADM
echo "Installing YADM..."
brew install yadm

# Use YADM to pull the rest of the ENV and Bootstrap files
echo "Activating YADM, calling bootstrap scripts..."
yadm clone https://github.com/binarynomad/.dotfiles.git

