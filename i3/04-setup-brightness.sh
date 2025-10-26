#!/bin/bash
# Script 4: Setup brightness control
# Configures brightnessctl permissions and udev rules

set -e  # Exit on error

echo "=========================================="
echo "Brightness Control Setup"
echo "=========================================="
echo ""

# Add user to video group
echo "Adding user '$USER' to video group..."
sudo usermod -a -G video "$USER"

# Create udev rules
UDEV_RULES="/etc/udev/rules.d/90-backlight.rules"
echo "Creating udev rules at: $UDEV_RULES"

sudo bash -c "cat > $UDEV_RULES" << 'EOF'
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
EOF

# Reload udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

echo ""
echo "=========================================="
echo "Brightness control setup complete!"
echo "=========================================="
echo ""
echo "IMPORTANT: You need to log out and log back in for"
echo "the video group membership to take effect."
echo ""
echo "After logging back in, test with:"
echo "  brightnessctl set 50%"
echo ""
echo "In i3, use:"
echo "  XF86MonBrightnessUp/Down keys"
echo ""
echo "Next steps:"
echo "  Run: ./05-setup-xinitrc.sh"
echo ""
