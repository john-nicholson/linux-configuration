#!/bin/bash
# Script 3: Setup power menu script
# Creates the power menu script used by i3 (Super+Shift+e)

set -e  # Exit on error

echo "=========================================="
echo "Power Menu Setup"
echo "=========================================="
echo ""

BIN_DIR="$HOME/.local/bin"
POWERMENU_SCRIPT="$BIN_DIR/powermenu.sh"

# Create bin directory if it doesn't exist
echo "Creating directory: $BIN_DIR"
mkdir -p "$BIN_DIR"

# Create the power menu script
echo "Creating power menu script at: $POWERMENU_SCRIPT"
cat > "$POWERMENU_SCRIPT" << 'EOF'
#!/bin/bash
# Simple power menu for i3

choice=$(echo -e "Lock\nLogout\nReboot\nShutdown" | dmenu -i -p "Power Menu:")

case "$choice" in
    Lock) i3lock -c 000000 ;;
    Logout) i3-msg exit ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
EOF

# Make it executable
echo "Making script executable..."
chmod +x "$POWERMENU_SCRIPT"

echo ""
echo "=========================================="
echo "Power menu setup complete!"
echo "=========================================="
echo ""
echo "Script location: $POWERMENU_SCRIPT"
echo "Usage: Press Super+Shift+e in i3"
echo ""
echo "Next steps:"
echo "  Run: ./04-setup-brightness.sh"
echo ""
