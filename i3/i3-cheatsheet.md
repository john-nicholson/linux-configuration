# i3 Window Manager Cheat Sheet

Quick reference for essential i3 keybindings. `Super` = Windows/Command key.

## Getting Started

### Launch Applications
| Key | Action |
|-----|--------|
| `Super + Enter` | Open terminal (xterm) |
| `Super + d` | Application launcher (dmenu) |

## Window Management

### Focus (Navigate Between Windows)
| Key | Action |
|-----|--------|
| `Super + h` | Focus left |
| `Super + j` | Focus down |
| `Super + k` | Focus up |
| `Super + l` | Focus right |

### Move Windows
| Key | Action |
|-----|--------|
| `Super + Shift + h` | Move window left |
| `Super + Shift + j` | Move window down |
| `Super + Shift + k` | Move window up |
| `Super + Shift + l` | Move window right |

### Window Actions
| Key | Action |
|-----|--------|
| `Super + Shift + q` | Kill/close window |
| `Super + f` | Toggle fullscreen |
| `Super + Space` | Toggle floating/tiling mode |

### Split Containers
| Key | Action |
|-----|--------|
| `Super + v` | Split vertically (next window below) |
| `Super + b` | Split horizontally (next window beside) |

## Workspaces

### Switch Workspaces
| Key | Action |
|-----|--------|
| `Super + 1` | Go to workspace 1 |
| `Super + 2` | Go to workspace 2 |
| `Super + 3` | Go to workspace 3 |
| `Super + 4` | Go to workspace 4 |
| `Super + 5` | Go to workspace 5 |
| `Super + 6` | Go to workspace 6 |
| `Super + 7` | Go to workspace 7 |
| `Super + 8` | Go to workspace 8 |
| `Super + 9` | Go to workspace 9 |

### Move Window to Workspace
| Key | Action |
|-----|--------|
| `Super + Shift + 1` | Move window to workspace 1 |
| `Super + Shift + 2` | Move window to workspace 2 |
| `Super + Shift + 3` | Move window to workspace 3 |
| ... | ... (same pattern for 4-9) |

## System Control

### i3 Management
| Key | Action |
|-----|--------|
| `Super + Shift + r` | Restart i3 (reload config) |
| `Super + Shift + c` | Reload i3 config |
| `Super + Shift + e` | Power menu (Lock/Logout/Reboot/Shutdown) |
| `Super + Shift + x` | Lock screen |

## Media Keys

### Volume Control
| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Increase volume 5% |
| `XF86AudioLowerVolume` | Decrease volume 5% |
| `XF86AudioMute` | Mute/unmute |

### Brightness Control
| Key | Action |
|-----|--------|
| `XF86MonBrightnessUp` | Increase brightness 10% |
| `XF86MonBrightnessDown` | Decrease brightness 10% |

### Screenshots
| Key | Action |
|-----|--------|
| `Print` | Take screenshot (saved to ~/Pictures/) |

## Common Workflows

### Opening Your First Terminal
1. Press `Super + Enter`
2. Terminal (xterm) opens

### Launching an Application
1. Press `Super + d`
2. Type application name
3. Press `Enter`

### Splitting Windows Side-by-Side
1. Open first window: `Super + Enter`
2. Split horizontal: `Super + b`
3. Open second window: `Super + Enter`
4. Both windows appear side-by-side

### Splitting Windows Top-and-Bottom
1. Open first window: `Super + Enter`
2. Split vertical: `Super + v`
3. Open second window: `Super + Enter`
4. Windows stack vertically

### Moving Between Workspaces
1. Press `Super + 2` to go to workspace 2
2. Press `Super + 1` to return to workspace 1

### Moving a Window to Another Workspace
1. Focus the window you want to move
2. Press `Super + Shift + 3` (moves to workspace 3)
3. Press `Super + 3` to follow it there

### Making a Window Fullscreen
1. Focus the window
2. Press `Super + f`
3. Press `Super + f` again to exit fullscreen

## Network & WiFi Configuration

### Method 1: Using nm-applet (GUI - Easiest)
1. Look for the network icon in the system tray (top-right of status bar)
2. Click the network manager icon (nm-applet)
3. Select your WiFi network from the list
4. Enter password when prompted

### Method 2: Command Line (if nm-applet isn't visible)
```bash
# List available WiFi networks
nmcli device wifi list

# Connect to a network
nmcli device wifi connect "NETWORK_NAME" password "YOUR_PASSWORD"

# Check connection status
nmcli device status

# Disconnect
nmcli device disconnect wlan0
```

### Method 3: Using nmtui (Text UI)
```bash
# Launch text-based network manager UI
nmtui

# Use arrow keys to navigate:
# - Select "Activate a connection"
# - Choose your WiFi network
# - Enter password
```

### Troubleshooting WiFi
```bash
# Check if NetworkManager is running
systemctl status NetworkManager

# Start NetworkManager if not running
sudo systemctl start NetworkManager

# Enable NetworkManager to start at boot
sudo systemctl enable NetworkManager

# Restart nm-applet if tray icon is missing
killall nm-applet
nm-applet &
```

## Tips

- **Floating Calculator:** Open calculator app, then `Super + Space` to make it float
- **Status Bar:** Top bar shows workspaces, system info, and tray icons
- **Network:** Click nm-applet icon in tray to manage WiFi (see Network & WiFi Configuration above)
- **Mouse:** Hold `Super` and drag floating windows with mouse

## Troubleshooting

**Volume keys not working?**
- Test manually: `amixer sset Master 5%+`
- Ensure you're in audio group

**Brightness keys not working?**
- Make sure you ran `04-setup-brightness.sh`
- Log out and back in after running it

**Can't remember a keybinding?**
- This file is at: `~/i3/i3-cheatsheet.md`
- Or check the config: `~/.config/i3/config`

## Learning More

- i3 User's Guide: https://i3wm.org/docs/userguide.html
- Config file location: `~/.config/i3/config`
- Edit and reload with `Super + Shift + c`
