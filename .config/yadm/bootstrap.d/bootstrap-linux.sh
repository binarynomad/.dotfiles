#!/usr/bin/env bash
# ---------------------------------------------
# LINUX Application Installs and Configs
# ---------------------------------------------

# Check if on the proper OS, and skip if not
export OS_TYPE="$(uname -s)"
if [[ "$OS_TYPE" != "Linux" ]]; then echo "Skipping Linux scripts..."; exit 0; fi
echo "Running ${OS_TYPE} Bootstrap..."

# Beginning Installation
echo "-------------------------------------------------------"
echo "Starting Bootstrap install for (${OS_TYPE})"
echo "-------------------------------------------------------"

# ---------------------------------------------
# OS DEFAULT SETTINGS
# ---------------------------------------------

# Setup some default directories
echo "Setting up default directories..."
for dir in bin tmp dev ; do
    if [[! -d ${HOME}/$dir ]]; then mkdir ${HOME}/$dir; fi
    echo "Created ${HOME}/$dir"
done


# ---------------------------------------------
# CLI APPS: Default Install
# ---------------------------------------------

# Prepare OS
echo "Preparing OS..."
sudo apt update ; sudo apt upgrade -y ; sudo apt autoremove -y ; sudo apt autoclean -y


# Install some common CLI tools
echo "Installing common CLI tools..."
packages="bat fd-find jq ripgrep tldr"
apt update
for package in $packages; do
    sudo apt install -y $package
done



# ---------------------------------------------
# APPS CONFIG:
# ---------------------------------------------

echo "Linking some common CLI tools..."
# FD: Need to setup a link to fdfind so exports work properly.
ln -s $(which fdfind) ~/bin/fd

# BAT: Need to setup a link to batcat so exports work properly.
ln -s $(which batcat) ~/bin/bat