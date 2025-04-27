#!/usr/bin/env bash
# ---------------------------------------------
# LINUX Application Installs and Configs
# ---------------------------------------------

# Check if on the proper OS, and skip if not
export OS_TYPE="$(uname -s)"
if [[ "$OS_TYPE" != "Linux" ]]; then echo -e "\nSkipping Linux scripts..."; exit 0; fi

# Beginning Installation
clear
echo "-------------------------------------------------------"
echo "Starting Bootstrap install for (${OS_TYPE})"
echo "-------------------------------------------------------"

# ---------------------------------------------
# OS DEFAULT SETTINGS
# ---------------------------------------------

# Setup some default directories
echo ""
echo "Setting up default directories..."
for dir in bin tmp dev; do
    if [ ! -d "${HOME}/$dir" ]; then
        mkdir -p "${HOME}/$dir"
        echo "Created ${HOME}/$dir"
    else
        echo "${HOME}/$dir already exists"
    fi
done

# ---------------------------------------------
# CLI APPS: Default Install
# ---------------------------------------------

# Prepare OS
echo ""
echo -e "\n\nUpdating APT system..."; sudo apt update
echo -e "\n\nUpgrading APT system..."; sudo apt upgrade -y
echo -e "\n\nAutoremove APT system..."; sudo apt autoremove -y
echo -e "\n\nAutoclean APT system..."; sudo apt autoclean -y

# Setup Locales for (en_US.UTF-8)
echo -e "\nSetup Locales for en.US.UTF-8"
sudo apt install locales-all
sudo locale-gen en_US.UTF-8

# Install some common CLI tools
echo ""
echo "Installing common CLI tools..."

packages="bat fd-find jq ncdu ripgrep tldr tree"

for package in $packages; do
    echo -e "\nInstalling ${package}"
    sudo apt install -y $package
done

# ---------------------------------------------
# APPS CONFIG:
# ---------------------------------------------

echo -e "\nLinking some common CLI tools..."

# FD: Need to setup a link to fdfind so exports work properly.
echo -e "\nLinking FD..." ; ln -s $(which fdfind) ${HOME}/bin/fd

# BAT: Need to setup a link to batcat so exports work properly.
echo -e "\nLinking BAT..." ; ln -s $(which batcat) ${HOME}/bin/bat