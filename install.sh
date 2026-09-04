#!/bin/bash
# =========================================================
# PulseCheck Installer
# Installs pulsecheck.sh as a system-wide command: `pulsecheck`
# Usage:
#   curl -sSL https://raw.githubusercontent.com/Muntaha-Ghafoor/pulsecheck/main/install.sh | bash
# =========================================================

set -e

REPO_RAW="https://raw.githubusercontent.com/Muntaha-Ghafoor/pulsecheck/main/pulsecheck.sh"
INSTALL_DIR="/usr/local/bin"
INSTALL_NAME="pulsecheck"

echo "Installing PulseCheck..."

# Download the latest script
if command -v curl >/dev/null 2>&1; then
    curl -sSL "$REPO_RAW" -o "/tmp/$INSTALL_NAME"
elif command -v wget >/dev/null 2>&1; then
    wget -q "$REPO_RAW" -O "/tmp/$INSTALL_NAME"
else
    echo "Error: curl or wget is required to install PulseCheck."
    exit 1
fi

chmod +x "/tmp/$INSTALL_NAME"

# Move into PATH (requires sudo if not root)
if [ "$EUID" -ne 0 ]; then
    echo "Installing to $INSTALL_DIR (requires sudo)..."
    sudo mv "/tmp/$INSTALL_NAME" "$INSTALL_DIR/$INSTALL_NAME"
else
    mv "/tmp/$INSTALL_NAME" "$INSTALL_DIR/$INSTALL_NAME"
fi

echo ""
echo "PulseCheck installed successfully!"
echo "Run it from anywhere with: $INSTALL_NAME"
