#!/bin/bash

# Define source and destination file paths
TEMPLATE="/etc/pam.d/sudo_local.template"
DEST="/etc/pam.d/sudo_local"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Check if the template file exists
if [ ! -f "$TEMPLATE" ]; then
  echo "Error: Template file $TEMPLATE not found"
  exit 1
fi

# Copy the template file to the destination
cp "$TEMPLATE" "$DEST"
echo "Copied $TEMPLATE to $DEST"

# Uncomment the line "#auth sufficient pam_tid.so"
sed -i '' '/^#auth[[:space:]]*sufficient[[:space:]]*pam_tid\.so/s/^#//' "$DEST"
echo "Uncommented the pam_tid.so line"

echo "Script completed"
