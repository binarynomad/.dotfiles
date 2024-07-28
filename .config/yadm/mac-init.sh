#!/bin/sh

# Start the Brew Installer which will also install Xcode/git
if [[ -e /opt/homebrew/bin/brew ]]; then
  echo -e "\nXcode, Git, & Brew are already installed; continuing..."
else
  echo -e "\nInstalling Xcode, Git, & Brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Temporarily envoke the brew environment, this will be replaced
# by the YADM entry in .zprofile
echo -e "\nEnvoking BREW enviroment..."
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use Brew to install YADM
echo -e "\nInstalling YADM..."
brew install yadm

# Use YADM to pull the rest of the ENV and Bootstrap files
echo -e "\nActivating YADM, calling bootstrap scripts..."
yadm clone https://github.com/binarynomad/.dotfiles.git