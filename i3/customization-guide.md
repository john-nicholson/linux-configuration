# i3 Customization Guide

This guide covers common customizations for your i3 setup.

## Changing Text/Font Scaling

### Method 1: XTerm Font Size (Recommended)

Create or edit `~/.Xresources`:

```bash
nano ~/.Xresources
```

Add these lines:

```
! XTerm font settings
XTerm*faceName: DejaVu Sans Mono
XTerm*faceSize: 12

! Alternative: Use bitmap fonts (can be sharper on old displays)
! XTerm*font: -*-fixed-medium-r-*-*-18-*-*-*-*-*-iso10646-*

! Optional: Better colors
XTerm*background: black
XTerm*foreground: white
XTerm*cursorColor: green

! Scrollback buffer
XTerm*saveLines: 2000
```

**Font size values:**
- `8` - Very small
- `10` - Small (default)
- `12` - Medium
- `14` - Large
- `16` - Extra large
- `18` - Very large

After editing, reload the settings:

```bash
xrdb ~/.Xresources
```

Then open a new xterm to see the changes: `Super + Enter`

### Method 2: Launch XTerm with Specific Font Size

Modify i3 config to launch xterm with a specific font size:

```bash
nano ~/.config/i3/config
```

Change the terminal definition:

```
# For larger font (size 14)
set $term xterm -fa 'DejaVu Sans Mono' -fs 14

# Or for bitmap font
# set $term xterm -fn '-*-fixed-medium-r-*-*-18-*-*-*-*-*-iso10646-*'
```

Reload i3: `Super + Shift + c`

### Method 3: i3 Title Bar and Status Bar Font

Edit i3 config:

```bash
nano ~/.config/i3/config
```

Change the font line near the top:

```
# Small font
font pango:DejaVu Sans Mono 8

# Medium font (default)
font pango:DejaVu Sans Mono 10

# Large font
font pango:DejaVu Sans Mono 12

# Extra large font
font pango:DejaVu Sans Mono 14
```

Reload i3: `Super + Shift + c`

## Moving Windows Between Workspaces (Desktops)

### Quick Reference
- **Move focused window to workspace 2:** `Super + Shift + 2`
- **Move focused window to workspace 3:** `Super + Shift + 3`
- **Move to any workspace 1-9:** `Super + Shift + [1-9]`

### Step-by-Step Process

1. **Focus the window you want to move**
   - Click on it, or navigate with `Super + h/j/k/l`

2. **Move it to desired workspace**
   - Press `Super + Shift + [workspace number]`
   - Example: `Super + Shift + 3` moves to workspace 3

3. **Follow the window (optional)**
   - Press `Super + [workspace number]` to switch to that workspace
   - Example: `Super + 3` switches to workspace 3

### Examples

**Moving a terminal to workspace 2:**
1. Focus the terminal window
2. Press `Super + Shift + 2`
3. The window moves to workspace 2
4. Press `Super + 2` to go to workspace 2 and see it

**Organizing windows across workspaces:**
- Workspace 1: Web browser
- Workspace 2: Terminals
- Workspace 3: Text editor
- Workspace 4: File manager

## Status Bar Position

### Move Bar to Bottom

Edit i3 config:

```bash
nano ~/.config/i3/config
```

Find the `bar {` section and change:

```
bar {
  position bottom    # Change from 'top' to 'bottom'
  status_command i3status
  tray_output primary
}
```

Reload i3: `Super + Shift + c`

### Move Bar to Top

Change `position bottom` to `position top`

### Hide the Bar (Show Only When Super is Pressed)

```
bar {
  position bottom
  status_command i3status
  tray_output primary
  mode hide           # Add this line
  hidden_state hide   # Add this line
  modifier $mod       # Add this line - shows bar when Super is held
}
```

## Additional Bar Customization

### Change Bar Colors

```
bar {
  position bottom
  status_command i3status
  tray_output primary
  
  colors {
    background #000000
    statusline #ffffff
    separator  #666666
    
    # workspace button colors
    #                  border  bg      text
    focused_workspace  #4c7899 #285577 #ffffff
    active_workspace   #333333 #5f676a #ffffff
    inactive_workspace #333333 #222222 #888888
    urgent_workspace   #2f343a #900000 #ffffff
  }
}
```

### Increase Bar Height (Larger Text/Icons)

```
bar {
  position bottom
  status_command i3status
  tray_output primary
  height 25          # Default is auto, try 25-35 for larger
  font pango:DejaVu Sans Mono 12  # Increase bar font too
}
```

## Quick Customization Workflow

1. **Edit config:**
   ```bash
   nano ~/.config/i3/config
   ```

2. **Make changes**

3. **Save:** `Ctrl + X`, then `Y`, then `Enter`

4. **Reload i3:** `Super + Shift + c`

5. **Test changes**

6. **If something breaks:**
   - Restore backup: `cp ~/.config/i3/config.backup.* ~/.config/i3/config`
   - Or re-run: `~/i3/08-fix-config-loading.sh`

## Common Customizations Summary

### Change xterm font size
```bash
# Edit ~/.Xresources
XTerm*faceSize: 14
# Then: xrdb ~/.Xresources
```

### Move status bar to bottom
```bash
# Edit ~/.config/i3/config
# In bar { } section: position bottom
# Then: Super + Shift + c
```

### Move window to workspace 3
```bash
# Focus window, then: Super + Shift + 3
```

### Change i3 font size
```bash
# Edit ~/.config/i3/config
# Near top: font pango:DejaVu Sans Mono 12
# Then: Super + Shift + c
```

## Testing Your Changes

After any change:
1. Save the file
2. Reload i3: `Super + Shift + c`
3. If i3 crashes or acts weird:
   - Switch to TTY: `Ctrl + Alt + F2`
   - Check config: `i3 -C -c ~/.config/i3/config`
   - Fix errors shown
   - Restart i3: `killall i3 && startx`

## Backing Up Your Config

Before making major changes:

```bash
cp ~/.config/i3/config ~/.config/i3/config.backup.$(date +%Y%m%d_%H%M%S)
```

## More Resources

- i3 User's Guide: https://i3wm.org/docs/userguide.html
- i3 Config Reference: https://i3wm.org/docs/userguide.html#configuring
- XTerm Resources: https://wiki.archlinux.org/title/Xterm
