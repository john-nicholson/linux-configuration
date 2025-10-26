# i3 Window Manager Setup Guide for Debian i386

This guide provides step-by-step instructions for setting up i3 window manager on an old i386 machine running Debian, optimized for lightweight performance.

## Prerequisites

- A working Debian installation (i386 architecture)
- Root or sudo access
- Internet connection for package installation

## Installation Steps

### 1. Update System Packages

```bash
sudo apt-get update
sudo apt-get upgrade
```

### 2. Install i3 and Essential Components

```bash
sudo apt-get install -y \
    i3 \
    i3status \
    i3lock \
    xserver-xorg \
    xinit \
    xterm \
    dmenu \
    feh \
    network-manager \
    network-manager-gnome \
    alsa-utils \
    brightnessctl \
    scrot \
    fonts-dejavu
```

#### Package Breakdown:

- **i3** - The tiling window manager
- **i3status** - Status bar information provider
- **i3lock** - Screen locker
- **xserver-xorg** - X Window System server
- **xinit** - X initialization scripts
- **xterm** - Terminal emulator (lightweight)
- **dmenu** - Application launcher
- **feh** - Image viewer and wallpaper setter
- **network-manager** - Network management
- **network-manager-gnome** - Provides nm-applet for system tray
- **alsa-utils** - Audio utilities (includes amixer)
- **brightnessctl** - Screen brightness control
- **scrot** - Screenshot utility
- **fonts-dejavu** - DejaVu Sans Mono font

### 3. Configure i3

#### Create i3 config directory:

```bash
mkdir -p ~/.config/i3
```

#### Copy the configuration file:

```bash
cp /path/to/i3config.example ~/.config/i3/config
```

Or create it manually by copying the configuration from the i3config.example file.

### 4. Setup Wallpaper

Place your wallpaper image in your home directory:

```bash
cp /path/to/your/wallpaper.jpg ~/.wallpaper.jpg
```

If you don't have a wallpaper, you can skip this or create a solid color background later.

### 5. Create Power Menu Script (Optional)

The config references a power menu script. Create it:

```bash
mkdir -p ~/.local/bin
```

Create `~/.local/bin/powermenu.sh`:

```bash
#!/bin/bash
# Simple power menu for i3

choice=$(echo -e "Lock\nLogout\nReboot\nShutdown" | dmenu -i -p "Power Menu:")

case "$choice" in
    Lock) i3lock -c 000000 ;;
    Logout) i3-msg exit ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
```

Make it executable:

```bash
chmod +x ~/.local/bin/powermenu.sh
```

### 6. Configure X to Start i3

Create or edit `~/.xinitrc`:

```bash
echo "exec i3" > ~/.xinitrc
```

### 7. Setup Brightness Control (Optional)

For brightnessctl to work without root, add your user to the video group:

```bash
sudo usermod -a -G video $USER
```

You may also need to configure udev rules. Create `/etc/udev/rules.d/90-backlight.rules`:

```bash
sudo nano /etc/udev/rules.d/90-backlight.rules
```

Add:

```
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
```

Reload udev rules:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

### 8. Start i3

#### From Console:

```bash
startx
```

#### Or configure automatic login with a display manager (optional):

```bash
sudo apt-get install lightdm
```

Then select i3 from the session menu when logging in.

## Post-Installation Configuration

### Essential Keybindings

- **Super + Enter** - Open terminal (xterm)
- **Super + d** - Application launcher (dmenu)
- **Super + Shift + q** - Close window
- **Super + h/j/k/l** - Navigate windows (left/down/up/right)
- **Super + Shift + h/j/k/l** - Move windows
- **Super + 1-9** - Switch workspaces
- **Super + Shift + 1-9** - Move window to workspace
- **Super + f** - Fullscreen toggle
- **Super + Shift + r** - Restart i3
- **Super + Shift + c** - Reload config
- **Super + Shift + e** - Power menu
- **Super + Shift + x** - Lock screen
- **Print** - Screenshot (saves to ~/Pictures/)

### Volume Control:

- **XF86AudioRaiseVolume** - Increase volume
- **XF86AudioLowerVolume** - Decrease volume
- **XF86AudioMute** - Mute/unmute

### Brightness Control:

- **XF86MonBrightnessUp** - Increase brightness
- **XF86MonBrightnessDown** - Decrease brightness

## Performance Optimization Tips

### For Very Limited RAM (< 512 MB):

1. Disable unnecessary startup applications
2. Use lighter alternatives:
   ```bash
   sudo apt-get install --no-install-recommends i3
   ```

3. Consider using `urxvt` instead of `xterm` for better performance:
   ```bash
   sudo apt-get install rxvt-unicode
   ```
   Then update the config: `set $term urxvt`

### Disable Compositor

For i386 machines, avoid using compositors (picom/compton) as they consume extra resources.

### Reduce i3status Updates

Edit `~/.config/i3status/config` to reduce refresh intervals if needed.

## Troubleshooting

### i3 doesn't start:

Check X server logs:
```bash
cat ~/.local/share/xorg/Xorg.0.log
```

### nm-applet not showing:

Ensure NetworkManager service is running:
```bash
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

### Brightness keys not working:

Check available backlight devices:
```bash
ls /sys/class/backlight/
```

Verify permissions on brightness file.

### Volume keys not working:

Test amixer directly:
```bash
amixer sset Master 5%+
```

Ensure your user is in the audio group:
```bash
sudo usermod -a -G audio $USER
```

## Additional Resources

- i3 User's Guide: https://i3wm.org/docs/userguide.html
- i3status documentation: https://i3wm.org/i3status/manpage.html
- Debian wiki: https://wiki.debian.org/i3wm

## Notes

- This configuration is optimized for old hardware with minimal resource usage
- DPMS settings prevent aggressive screen blanking (configured for 5/10/15/20 minutes)
- No compositor is used to save resources
- ALSA is used instead of PulseAudio for lower overhead
