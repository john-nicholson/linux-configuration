#!/bin/bash
# Script 7: Setup LightDM to use i3 as default session
# Switches from XFCE to i3 with graphical login

set -e  # Exit on error

echo "=========================================="
echo "LightDM i3 Session Setup"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run as root. Use your regular user account."
    echo "The script will prompt for sudo password when needed."
    exit 1
fi

# Install LightDM if not already installed
echo "Checking for LightDM..."
if ! dpkg -l | grep -q "^ii.*lightdm "; then
    echo "LightDM not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y lightdm
    echo ""
    echo "During installation, you may be asked to choose a display manager."
    echo "Select 'lightdm' when prompted."
else
    echo "LightDM is already installed."
fi

echo ""

# Set LightDM as the default display manager
echo "Setting LightDM as the default display manager..."
sudo dpkg-reconfigure lightdm

echo ""

# Create i3 desktop session file if it doesn't exist
I3_DESKTOP="/usr/share/xsessions/i3.desktop"
if [ ! -f "$I3_DESKTOP" ]; then
    echo "Creating i3 desktop session file..."
    sudo bash -c "cat > $I3_DESKTOP" << 'EOF'
[Desktop Entry]
Name=i3
Comment=improved dynamic tiling window manager
Exec=i3
Type=Application
EOF
    echo "Created: $I3_DESKTOP"
else
    echo "i3 desktop session file already exists."
fi

echo ""

# Set i3 as default session for current user
echo "Setting i3 as default session for user: $USER"

# Create .dmrc file to set default session
cat > "$HOME/.dmrc" << EOF
[Desktop]
Session=i3
EOF

chmod 644 "$HOME/.dmrc"

echo "Created: $HOME/.dmrc"

echo ""

# Optional: Remove XFCE autostart if user wants
echo "Do you want to disable XFCE from autostarting? (y/n)"
read -p "This will keep XFCE installed but prevent it from auto-loading: " remove_xfce

if [ "$remove_xfce" = "y" ] || [ "$remove_xfce" = "Y" ]; then
    # Create autostart disable directory
    mkdir -p "$HOME/.config/autostart"

    # Disable common XFCE autostart applications
    for app in xfce4-panel xfdesktop xfwm4 xfsettingsd; do
        if [ -f "/etc/xdg/autostart/${app}.desktop" ]; then
            cat > "$HOME/.config/autostart/${app}.desktop" << EOF
[Desktop Entry]
Hidden=true
EOF
            echo "Disabled autostart: $app"
        fi
    done
fi

echo ""
echo "=========================================="
echo "LightDM setup complete!"
echo "=========================================="
echo ""
echo "Changes made:"
echo "  - LightDM installed and set as default display manager"
echo "  - i3 session file created"
echo "  - i3 set as default session for $USER"
echo ""
echo "Next steps:"
echo "  1. Reboot your system: sudo reboot"
echo "  2. At the login screen, i3 should be selected by default"
echo "  3. If not, click the session icon and select 'i3'"
echo ""
echo "To switch back to XFCE later:"
echo "  - At login screen, select 'Xfce Session' from session menu"
echo ""
