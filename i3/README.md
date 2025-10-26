# i3 Window Manager Setup for Debian i386

This directory contains everything you need to set up i3 window manager on an old i386 Debian machine, including automated setup scripts.

## Quick Start

Run these scripts **in order** on your Debian i386 machine:

```bash
cd i3
./01-install-packages.sh
./02-setup-i3-config.sh
./03-setup-powermenu.sh
./04-setup-brightness.sh
./05-setup-xinitrc.sh
./06-setup-wallpaper.sh  # Optional
```

Then start i3:
```bash
startx
```

## Scripts Overview

### 01-install-packages.sh
**What it does:**
- Updates package lists
- Installs all required packages for i3 (window manager, terminal, launcher, utilities)

**Packages installed:**
- i3, i3status, i3lock (window manager components)
- xserver-xorg, xinit (X Window System)
- xterm, dmenu (terminal and launcher)
- feh (wallpaper)
- network-manager, nm-applet (networking)
- alsa-utils (audio)
- brightnessctl (brightness control)
- scrot (screenshots)
- fonts-dejavu (fonts)

**Run time:** 5-15 minutes depending on hardware and connection speed

---

### 02-setup-i3-config.sh
**What it does:**
- Creates ~/.config/i3 directory
- Copies i3config.example to ~/.config/i3/config
- Backs up existing config if present

**No sudo required**

---

### 03-setup-powermenu.sh
**What it does:**
- Creates ~/.local/bin directory
- Installs power menu script (Lock/Logout/Reboot/Shutdown)
- Makes script executable

**Usage in i3:** Press `Super+Shift+e`

**No sudo required**

---

### 04-setup-brightness.sh
**What it does:**
- Adds user to video group
- Creates udev rules for brightness control
- Reloads udev rules

**Important:** You must log out and log back in after running this script for the video group to take effect.

**Requires sudo**

---

### 05-setup-xinitrc.sh
**What it does:**
- Creates ~/.xinitrc file
- Configures X to start i3
- Backs up existing .xinitrc if present

**After running:** Use `startx` command to launch i3

**No sudo required**

---

### 06-setup-wallpaper.sh (Optional)
**What it does:**
- Interactive script to set up wallpaper
- Options:
  1. Copy existing image
  2. Create solid color background (requires imagemagick)
  3. Skip setup

**No sudo required** (unless using imagemagick option and it's not installed)

---

## Troubleshooting

### DVD/CD-ROM Error During Package Installation

If apt-get asks for a DVD/CD-ROM, disable the DVD sources:

```bash
sudo sed -i '/^deb cdrom:/s/^/# /' /etc/apt/sources.list
sudo apt-get update
```

Then re-run `./01-install-packages.sh`

### Brightness Keys Not Working

1. Make sure you ran script 04
2. Log out and log back in
3. Check if backlight device exists:
   ```bash
   ls /sys/class/backlight/
   ```

### Network Manager Not Starting

```bash
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

### i3 Won't Start

Check X server logs:
```bash
cat ~/.local/share/xorg/Xorg.0.log
```

## Essential Keybindings

Once i3 is running:

- `Super+Enter` - Open terminal
- `Super+d` - Application launcher (dmenu)
- `Super+Shift+q` - Close window
- `Super+h/j/k/l` - Navigate windows (left/down/up/right)
- `Super+1-9` - Switch workspaces
- `Super+Shift+1-9` - Move window to workspace
- `Super+f` - Fullscreen
- `Super+Shift+r` - Restart i3
- `Super+Shift+e` - Power menu
- `Super+Shift+x` - Lock screen
- `Print` - Screenshot (saves to ~/Pictures/)

### Volume Control:
- `XF86AudioRaiseVolume` - Increase volume
- `XF86AudioLowerVolume` - Decrease volume
- `XF86AudioMute` - Mute/unmute

### Brightness Control:
- `XF86MonBrightnessUp` - Increase brightness
- `XF86MonBrightnessDown` - Decrease brightness

## Files in This Directory

- `i3config.example` - The i3 window manager configuration
- `i3-debian-i386-setup.md` - Detailed manual setup guide
- `01-install-packages.sh` - Package installation script
- `02-setup-i3-config.sh` - Configuration setup script
- `03-setup-powermenu.sh` - Power menu installation script
- `04-setup-brightness.sh` - Brightness control setup script
- `05-setup-xinitrc.sh` - X initialization setup script
- `06-setup-wallpaper.sh` - Wallpaper setup script (optional)

## Manual Setup

If you prefer manual setup or want more detailed explanations, see `i3-debian-i386-setup.md`

## Performance Notes

This configuration is optimized for old i386 hardware:
- No compositor (no transparency/shadows overhead)
- ALSA instead of PulseAudio
- Lightweight terminal (xterm)
- Minimal status bar (i3status)
- `focus_follows_mouse no` for better performance
