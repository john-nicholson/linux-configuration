#!/bin/bash
# Script 2: Setup i3 configuration
# Copies the i3 config file to the correct location

set -e  # Exit on error

echo "=========================================="
echo "i3 Configuration Setup"
echo "=========================================="
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR="$HOME/.config/i3"
CONFIG_FILE="$CONFIG_DIR/config"

# Create config directory if it doesn't exist
echo "Creating i3 config directory at: $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

# Backup existing config if present
if [ -f "$CONFIG_FILE" ]; then
    BACKUP_FILE="$CONFIG_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backing up existing config to: $BACKUP_FILE"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
fi

# Copy the example config
echo "Copying i3 config from: $SCRIPT_DIR/i3config.example"
cp "$SCRIPT_DIR/i3config.example" "$CONFIG_FILE"

echo ""
echo "=========================================="
echo "i3 configuration setup complete!"
echo "=========================================="
echo ""
echo "Config file location: $CONFIG_FILE"
echo ""
echo "Next steps:"
echo "  Run: ./03-setup-powermenu.sh"
echo ""
