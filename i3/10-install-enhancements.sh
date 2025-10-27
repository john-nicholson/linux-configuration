#!/bin/bash
# Script 10: Install development environment enhancements
# Installs Emacs, git tools, and sets up enhanced terminal

set -e  # Exit on error

echo "=========================================="
echo "i3 Development Environment Enhancements"
echo "=========================================="
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Please do not run as root. Use your regular user account."
    echo "The script will prompt for sudo password when needed."
    exit 1
fi

echo "This script will install and configure:"
echo "  1. Emacs text editor (lightweight terminal version)"
echo "  2. Git with enhanced prompt showing branch/status"
echo "  3. Tmux terminal multiplexer"
echo "  4. Useful git aliases and configurations"
echo ""
read -p "Continue? (y/n): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "Step 1: Installing packages"
echo "============================="
echo "Installing: emacs-nox, git, tmux..."
sudo apt-get update
sudo apt-get install -y emacs-nox git tmux curl

echo ""
echo "Step 2: Setting up Git prompt"
echo "=============================="

# Download git-prompt if not exists
if [ ! -f "$HOME/.git-prompt.sh" ]; then
    echo "Downloading git-prompt.sh..."
    curl -o "$HOME/.git-prompt.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    echo "✓ Downloaded git-prompt.sh"
else
    echo "✓ git-prompt.sh already exists"
fi

echo ""
echo "Step 3: Configuring Bash prompt"
echo "================================"

# Backup .bashrc
if [ -f "$HOME/.bashrc" ]; then
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
    echo "✓ Backed up .bashrc"
fi

# Check if git-prompt is already sourced
if ! grep -q "git-prompt.sh" "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" << 'EOF'

# === Git-enhanced prompt (added by i3 enhancements script) ===
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
fi
EOF
    echo "✓ Added git-prompt to .bashrc"
else
    echo "✓ git-prompt already configured in .bashrc"
fi

echo ""
echo "Step 4: Adding Git aliases"
echo "=========================="

# Check if aliases already exist
if ! grep -q "# Git aliases (i3 enhancements)" "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" << 'EOF'

# === Git aliases (i3 enhancements) ===
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gpl='git pull'
EOF
    echo "✓ Added git aliases to .bashrc"
else
    echo "✓ Git aliases already configured"
fi

echo ""
echo "Step 5: Basic Emacs configuration"
echo "=================================="

EMACS_CONFIG="$HOME/.emacs"

if [ ! -f "$EMACS_CONFIG" ]; then
    cat > "$EMACS_CONFIG" << 'EOF'
;; Basic Emacs configuration for i3/i386

;; Disable startup message
(setq inhibit-startup-message t)

;; Show line numbers
(global-display-line-numbers-mode t)

;; Show column number in mode line
(column-number-mode t)

;; Highlight matching parentheses
(show-paren-mode t)

;; Enable syntax highlighting
(global-font-lock-mode t)

;; Set tab width
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Better backup settings
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; Create backup directory
(make-directory "~/.emacs.d/backups" t)
(make-directory "~/.emacs.d/auto-save-list" t)

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Smooth scrolling
(setq scroll-step 1)
(setq scroll-conservatively 10000)

;; Enable clipboard
(setq x-select-enable-clipboard t)

;; Show file path in title bar
(setq frame-title-format '("Emacs - " buffer-file-name))
EOF
    echo "✓ Created basic Emacs configuration at: $EMACS_CONFIG"
else
    echo "✓ Emacs configuration already exists (not overwriting)"
fi

echo ""
echo "Step 6: Basic Tmux configuration"
echo "================================="

TMUX_CONFIG="$HOME/.tmux.conf"

if [ ! -f "$TMUX_CONFIG" ]; then
    cat > "$TMUX_CONFIG" << 'EOF'
# Basic tmux configuration for i3

# Use Ctrl+a as prefix (easier to reach than Ctrl+b)
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Split panes with more intuitive keys
bind | split-window -h
bind - split-window -v

# Enable mouse support
set -g mouse on

# Start window numbering at 1
set -g base-index 1

# Increase scrollback buffer
set -g history-limit 10000

# Status bar at bottom with simple style
set -g status-position bottom
set -g status-bg black
set -g status-fg white
set -g status-left '[#S] '
set -g status-right '%H:%M %d-%b-%y'

# Highlight active window
setw -g window-status-current-style 'bg=blue,fg=white,bold'

# Vim-like pane navigation
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
EOF
    echo "✓ Created tmux configuration at: $TMUX_CONFIG"
else
    echo "✓ Tmux configuration already exists (not overwriting)"
fi

echo ""
echo "Step 7: Adding i3 keybinding for Emacs"
echo "======================================="

I3_CONFIG="$HOME/.config/i3/config"

if [ -f "$I3_CONFIG" ]; then
    if ! grep -q "bindsym \$mod+e exec emacs" "$I3_CONFIG"; then
        # Add before the lock screen binding
        sed -i '/# --- Lock screen ---/i # Launch Emacs\nbindsym $mod+e exec emacs\n' "$I3_CONFIG"
        echo "✓ Added Super+e keybinding to launch Emacs"
        echo "  Reload i3 with: Super + Shift + c"
    else
        echo "✓ Emacs keybinding already exists in i3 config"
    fi
else
    echo "⚠ i3 config not found. Manually add this line to your i3 config:"
    echo "  bindsym \$mod+e exec emacs"
fi

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "✓ Installed packages:"
echo "  - emacs-nox (terminal Emacs)"
echo "  - git with enhanced prompt"
echo "  - tmux (terminal multiplexer)"
echo ""
echo "✓ Configurations created:"
echo "  - ~/.bashrc (git prompt + aliases)"
echo "  - ~/.emacs (basic Emacs config)"
echo "  - ~/.tmux.conf (tmux settings)"
echo ""
echo "To activate changes:"
echo "  1. Reload bash: source ~/.bashrc"
echo "  2. Or log out and back in"
echo "  3. Reload i3: Super + Shift + c"
echo ""
echo "Quick reference:"
echo "  - Launch Emacs: Super + e (or type 'emacs')"
echo "  - Launch Tmux: tmux"
echo "  - Git aliases: gs, ga, gc, gp, gl, gd, gb, gco, gpl"
echo ""
echo "For detailed usage, see:"
echo "  ~/i3/enhancements-guide.md"
echo ""
echo "Emacs basics:"
echo "  - Open file: Ctrl+x Ctrl+f"
echo "  - Save: Ctrl+x Ctrl+s"
echo "  - Exit: Ctrl+x Ctrl+c"
echo ""
echo "Tmux basics:"
echo "  - Split horizontal: Ctrl+a then |"
echo "  - Split vertical: Ctrl+a then -"
echo "  - Switch panes: Ctrl+a then h/j/k/l"
echo "  - Detach: Ctrl+a then d"
echo ""
