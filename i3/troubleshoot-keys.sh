#!/bin/bash
# Troubleshooting script for i3 keybindings
# Run this in a terminal to diagnose key issues

echo "=========================================="
echo "i3 Keybinding Troubleshooting"
echo "=========================================="
echo ""

echo "Step 1: Check if i3 is running"
echo "------------------------------"
if pgrep -x "i3" > /dev/null; then
    echo "✓ i3 is running"
else
    echo "✗ i3 is NOT running"
    exit 1
fi

echo ""
echo "Step 2: Check i3 config file"
echo "----------------------------"
if [ -f "$HOME/.config/i3/config" ]; then
    echo "✓ Config file exists: $HOME/.config/i3/config"
    echo ""
    echo "Checking modifier key setting:"
    grep "set \$mod" "$HOME/.config/i3/config"
else
    echo "✗ Config file NOT found"
    exit 1
fi

echo ""
echo "Step 3: Test if xterm is installed"
echo "-----------------------------------"
if command -v xterm &> /dev/null; then
    echo "✓ xterm is installed"
else
    echo "✗ xterm is NOT installed"
    echo "  Install with: sudo apt-get install xterm"
fi

echo ""
echo "Step 4: Test if dmenu is installed"
echo "-----------------------------------"
if command -v dmenu &> /dev/null; then
    echo "✓ dmenu is installed"
else
    echo "✗ dmenu is NOT installed"
    echo "  Install with: sudo apt-get install dmenu"
fi

echo ""
echo "Step 5: Check for i3 errors"
echo "---------------------------"
echo "Checking i3 log for errors..."
if [ -f "$HOME/.local/share/i3/i3log" ]; then
    echo "Last 10 lines of i3 log:"
    tail -10 "$HOME/.local/share/i3/i3log"
elif [ -f "$HOME/.i3/i3log" ]; then
    echo "Last 10 lines of i3 log:"
    tail -10 "$HOME/.i3/i3log"
else
    echo "No i3 log file found (might be OK)"
fi

echo ""
echo "=========================================="
echo "Manual Tests"
echo "=========================================="
echo ""
echo "Test 1: Launch xterm directly"
echo "------------------------------"
echo "Run this command: xterm"
echo "If it opens, xterm works."
echo ""
echo "Test 2: Launch dmenu directly"
echo "------------------------------"
echo "Run this command: dmenu_run"
echo "If it appears, dmenu works."
echo ""
echo "Test 3: Check Super/Mod4 key detection"
echo "---------------------------------------"
echo "We'll run 'xev' to detect keypresses."
echo "1. Run: xev"
echo "2. Press your Windows/Super key"
echo "3. Look for 'Super_L' or 'Mod4' in the output"
echo "4. Press Ctrl+C to exit xev"
echo ""
read -p "Press Enter to launch xev (press Super key, then Ctrl+C to exit)..."
xev

echo ""
echo "=========================================="
echo "Alternative: Try These Keys Instead"
echo "=========================================="
echo ""
echo "If Super key doesn't work, try:"
echo "  Alt + Enter     (if using Alt as modifier)"
echo "  Right-click     (to see if i3 menu appears)"
echo ""
echo "To change modifier to Alt:"
echo "  1. Edit: nano ~/.config/i3/config"
echo "  2. Change: set \$mod Mod4"
echo "  3. To:     set \$mod Mod1"
echo "  4. Save and reload: Super+Shift+c (or Alt+Shift+c)"
echo ""
