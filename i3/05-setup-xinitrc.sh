#!/bin/bash
# Script 5: Setup .xinitrc to start i3
# Configures X to launch i3 when starting X

set -e  # Exit on error

echo "=========================================="
echo "X Initialization Setup"
echo "=========================================="
echo ""

XINITRC="$HOME/.xinitrc"

# Backup existing .xinitrc if present
if [ -f "$XINITRC" ]; then
    BACKUP_FILE="$XINITRC.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backing up existing .xinitrc to: $BACKUP_FILE"
    cp "$XINITRC" "$BACKUP_FILE"
fi

# Create .xinitrc
echo "Creating .xinitrc at: $XINITRC"
echo "exec i3" > "$XINITRC"

echo ""
echo "=========================================="
echo "X initialization setup complete!"
echo "=========================================="
echo ""
echo "File created: $XINITRC"
echo ""
echo "To start i3, run:"
echo "  startx"
echo ""
echo "Optional: Run ./06-setup-wallpaper.sh to configure wallpaper"
echo ""
