#!/bin/bash
# Script 1: Install all required packages for i3 window manager
# Run this first to install all necessary software

set -e  # Exit on error

echo "=========================================="
echo "i3 Window Manager Package Installation"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run as root. Use your regular user account."
    echo "The script will prompt for sudo password when needed."
    exit 1
fi

echo "Updating package lists..."
sudo apt-get update

echo ""
echo "Installing i3 and essential components..."
echo "This may take a while on older hardware..."
echo ""

sudo apt-get install -y \
    i3 \
    i3status \
    i3lock \
    xserver-xorg \
    xinit \
    xterm \
    dmenu \
    feh \
    network-manager \
    network-manager-gnome \
    alsa-utils \
    brightnessctl \
    scrot \
    fonts-dejavu

echo ""
echo "=========================================="
echo "Package installation complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  Run: ./02-setup-i3-config.sh"
echo ""
