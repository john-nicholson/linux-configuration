#!/bin/bash
# Script 9: Simple config update script
# Just copies the latest config and reloads i3

set -e  # Exit on error

echo "=========================================="
echo "i3 Config Update"
echo "=========================================="
echo ""

CONFIG_FILE="$HOME/.config/i3/config"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Step 1: Backup current config"
echo "------------------------------"
if [ -f "$CONFIG_FILE" ]; then
    BACKUP="$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$CONFIG_FILE" "$BACKUP"
    echo "✓ Backed up to: $BACKUP"
else
    echo "No existing config found (first time setup)"
fi

echo ""
echo "Step 2: Copy latest config"
echo "--------------------------"
if [ -f "$SCRIPT_DIR/i3config.example" ]; then
    cp "$SCRIPT_DIR/i3config.example" "$CONFIG_FILE"
    echo "✓ Copied config from: $SCRIPT_DIR/i3config.example"
    echo "✓ Config updated at: $CONFIG_FILE"
else
    echo "✗ Error: i3config.example not found"
    exit 1
fi

echo ""
echo "Step 3: Reload i3"
echo "-----------------"
echo "Attempting to reload i3..."

# Try multiple methods to reload i3
if command -v i3-msg &> /dev/null; then
    if i3-msg reload 2>/dev/null; then
        echo "✓ i3 reloaded successfully with i3-msg"
    else
        echo "⚠ i3-msg reload failed, trying restart..."
        if i3-msg restart 2>/dev/null; then
            echo "✓ i3 restarted successfully"
        else
            echo "⚠ Could not reload via i3-msg"
            echo "   Please reload manually: Super + Shift + c"
        fi
    fi
else
    echo "⚠ i3-msg not found"
    echo "   Please reload manually: Super + Shift + c"
fi

echo ""
echo "=========================================="
echo "Config update complete!"
echo "=========================================="
echo ""
echo "Changes applied:"
echo "  - Status bar moved to bottom"
echo "  - Latest keybindings loaded"
echo ""
echo "If you don't see changes:"
echo "  1. Press: Super + Shift + c (reload config)"
echo "  2. Or press: Super + Shift + r (restart i3)"
echo ""
echo "To customize further, see:"
echo "  ~/i3/customization-guide.md"
echo ""
