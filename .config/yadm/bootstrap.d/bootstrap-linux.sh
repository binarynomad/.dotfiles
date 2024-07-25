#!/usr/bin/env bash
# ---------------------------------------------
# LINUX Application Installs and Configs
# ---------------------------------------------

# Check if on the proper OS, and skip if not
if [[ "$OS_TYPE" != "Linux" ]]; then echo "Skipping Linux scripts..."; exit 0; fi
echo "Running ${OS_TYPE} Bootstrap..."

# Beginning Installation
echo "-------------------------------------------------------"
echo "Starting Bootstrap install for (${OS_TYPE})"
echo "-------------------------------------------------------"

# ---------------------------------------------
# OS DEFAULT SETTINGS
# ---------------------------------------------
#
# ---------------------------------------------
# CLI APPS: Default Install
# ---------------------------------------------

# Prepare OS
sudo apt update; sudo apt upgrade -y; sudo apt autoremove -y; sudo apt autoclean -y

packages="bat jq tldr z"

apt update
for package in $packages; do
    apt install -y $package
done


# ---------------------------------------------
# APPS CONFIG:
# ---------------------------------------------
