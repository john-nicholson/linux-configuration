#!/bin/bash
# Script 6: Setup wallpaper (optional)
# Helps configure wallpaper for i3

set -e  # Exit on error

echo "=========================================="
echo "Wallpaper Setup (Optional)"
echo "=========================================="
echo ""

WALLPAPER_PATH="$HOME/.wallpaper.jpg"

echo "The i3 config expects a wallpaper at:"
echo "  $WALLPAPER_PATH"
echo ""
echo "Options:"
echo "  1) Copy an existing image to ~/.wallpaper.jpg"
echo "  2) Create a solid color background"
echo "  3) Skip wallpaper setup"
echo ""
read -p "Enter your choice (1/2/3): " choice

case "$choice" in
    1)
        read -p "Enter the path to your wallpaper image: " image_path
        if [ -f "$image_path" ]; then
            cp "$image_path" "$WALLPAPER_PATH"
            echo "Wallpaper copied to $WALLPAPER_PATH"
        else
            echo "Error: File not found: $image_path"
            exit 1
        fi
        ;;
    2)
        read -p "Enter hex color (e.g., 2f343f for dark gray): " color
        # Create a simple 1x1 pixel image and scale it
        # This requires imagemagick, so check if convert is available
        if command -v convert &> /dev/null; then
            convert -size 1x1 xc:"#${color}" "$WALLPAPER_PATH"
            echo "Solid color wallpaper created: #${color}"
        else
            echo "Error: imagemagick not installed."
            echo "Install with: sudo apt-get install imagemagick"
            echo "Or manually place a wallpaper at $WALLPAPER_PATH"
            exit 1
        fi
        ;;
    3)
        echo "Skipping wallpaper setup."
        echo "You can manually add a wallpaper later at: $WALLPAPER_PATH"
        ;;
    *)
        echo "Invalid choice. Skipping wallpaper setup."
        ;;
esac

echo ""
echo "=========================================="
echo "Wallpaper setup complete!"
echo "=========================================="
echo ""
echo "All setup scripts have been run!"
echo ""
echo "To start i3:"
echo "  startx"
echo ""
echo "After brightness setup (script 04), remember to:"
echo "  - Log out and back in for video group to take effect"
echo ""
