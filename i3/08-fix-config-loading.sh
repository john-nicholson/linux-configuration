#!/bin/bash
# Script 8: Fix i3 config loading issues
# Ensures config is properly formatted and forces i3 to reload

set -e  # Exit on error

echo "=========================================="
echo "i3 Config Loading Fix"
echo "=========================================="
echo ""

CONFIG_FILE="$HOME/.config/i3/config"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if we're in i3
if ! pgrep -x "i3" > /dev/null; then
    echo "Error: i3 is not running"
    exit 1
fi

echo "Step 1: Backup current config"
echo "------------------------------"
if [ -f "$CONFIG_FILE" ]; then
    BACKUP="$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$CONFIG_FILE" "$BACKUP"
    echo "Backed up to: $BACKUP"
fi

echo ""
echo "Step 2: Copy fresh config from i3config.example"
echo "------------------------------------------------"
if [ -f "$SCRIPT_DIR/i3config.example" ]; then
    cp "$SCRIPT_DIR/i3config.example" "$CONFIG_FILE"
    echo "✓ Copied config from: $SCRIPT_DIR/i3config.example"
else
    echo "✗ Error: i3config.example not found in $SCRIPT_DIR"
    exit 1
fi

echo ""
echo "Step 3: Verify config syntax"
echo "-----------------------------"
# i3 has a -C flag to check config without reloading
if i3 -C -c "$CONFIG_FILE"; then
    echo "✓ Config syntax is valid"
else
    echo "✗ Config has syntax errors!"
    echo "Restoring backup..."
    cp "$BACKUP" "$CONFIG_FILE"
    exit 1
fi

echo ""
echo "Step 4: Check config content"
echo "----------------------------"
echo "Modifier key setting:"
grep "set \$mod" "$CONFIG_FILE"
echo ""
echo "Terminal keybinding:"
grep "bindsym \$mod+Return" "$CONFIG_FILE"
echo ""
echo "Dmenu keybinding:"
grep "bindsym \$mod+d" "$CONFIG_FILE"

echo ""
echo "Step 5: Reload i3"
echo "-----------------"
echo "Reloading i3 configuration..."
i3-msg reload

sleep 2

echo ""
echo "Step 6: Verify config is loaded"
echo "--------------------------------"
if i3-msg -t get_config | grep -q "set \$mod"; then
    echo "✓ Config is now loaded!"
else
    echo "⚠ Config might not be fully loaded"
    echo "Trying restart instead of reload..."
    i3-msg restart
    sleep 2
fi

echo ""
echo "=========================================="
echo "Config loading fix complete!"
echo "=========================================="
echo ""
echo "Test your keybindings now:"
echo "  Super + Enter  = Open terminal"
echo "  Super + d      = Open dmenu"
echo "  Super + Shift + q = Close window"
echo ""
echo "If Super key still doesn't work:"
echo "  1. Try Alt key instead (Alt + Enter)"
echo "  2. Run xev to verify Super key detection"
echo "  3. Consider switching to Alt modifier"
echo ""
echo "To switch to Alt modifier permanently:"
echo "  nano ~/.config/i3/config"
echo "  Change: set \$mod Mod4"
echo "  To:     set \$mod Mod1"
echo "  Then run: i3-msg reload"
echo ""
