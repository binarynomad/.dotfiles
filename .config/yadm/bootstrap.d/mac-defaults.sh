#!/usr/bin/env bash
# ---------------------------------------------
# MACOS (DARWIN) Defaults
# This file uses the defaults command to setup initial preferences
# ---------------------------------------------

# Check if on the proper OS, and skip if not
export OS_TYPE="$(uname -s)"
if [[ "$OS_TYPE" != "Darwin" ]]; then echo "Skipping Mac/Darwin DEFAULTS..."; exit 0; fi

# Beginning Installation
echo ""
echo "-------------------------------------------------------"
echo "Starting DEFAULTS install for (${OS_TYPE})"
echo "-------------------------------------------------------"

# ---------------------------------------------
# OS DEFAULTS 
# ---------------------------------------------


