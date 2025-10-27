# i3 Environment Enhancements Guide

This guide covers installing and configuring powerful development tools for your i3 setup.

## Table of Contents
1. [Emacs Text Editor](#emacs-text-editor)
2. [Advanced Terminal with Git Integration](#advanced-terminal-with-git-integration)
3. [Claude Code Editor](#claude-code-editor)

---

## Emacs Text Editor

Emacs is a powerful, extensible text editor perfect for development work on older hardware.

### Installation

```bash
# Install Emacs (without GUI for better performance on i386)
sudo apt-get install emacs-nox

# Or install full Emacs with GUI support
sudo apt-get install emacs
```

**Recommended for i386:** Use `emacs-nox` (terminal-only) for better performance.

### Basic Usage

```bash
# Launch Emacs in terminal
emacs

# Open a specific file
emacs filename.txt

# Open with GUI (if installed)
emacs &
```

### Essential Emacs Commands

| Command | Action |
|---------|--------|
| `Ctrl + x, Ctrl + f` | Open file |
| `Ctrl + x, Ctrl + s` | Save file |
| `Ctrl + x, Ctrl + c` | Exit Emacs |
| `Ctrl + g` | Cancel command |
| `Ctrl + x, 2` | Split window horizontally |
| `Ctrl + x, 3` | Split window vertically |
| `Ctrl + x, o` | Switch between windows |
| `Ctrl + k` | Kill (cut) line |
| `Ctrl + y` | Yank (paste) |
| `Ctrl + space` | Set mark (start selection) |
| `Alt + w` | Copy region |
| `Ctrl + w` | Cut region |

### Basic Emacs Configuration

Create `~/.emacs` or `~/.emacs.d/init.el`:

```elisp
;; Basic Emacs configuration for i386

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

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Smooth scrolling
(setq scroll-step 1)
(setq scroll-conservatively 10000)

;; Enable clipboard
(setq x-select-enable-clipboard t)
```

### Launch Emacs from i3

Add to your i3 config:

```
# Launch Emacs
bindsym $mod+e exec emacs
```

Or use dmenu: `Super + d`, type `emacs`, press Enter.

### Emacs for Programming

Emacs has built-in support for many languages:
- Python: `python-mode` (built-in)
- JavaScript: `js-mode` (built-in)
- Shell scripts: `sh-mode` (built-in)
- Markdown: `markdown-mode` (may need install)

---

## Advanced Terminal with Git Integration

Enhance your terminal with a custom prompt showing git information.

### Option 1: Enhanced Bash Prompt with Git Branch

Edit `~/.bashrc`:

```bash
nano ~/.bashrc
```

Add this at the end:

```bash
# Git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Enhanced prompt with git info
# Format: user@host:path (git-branch) $
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '

# Show git status in colors
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
```

Reload:

```bash
source ~/.bashrc
```

### Option 2: Full-Featured Git Prompt

Install git-prompt:

```bash
# Download git-prompt
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

# Add to ~/.bashrc
echo 'source ~/.git-prompt.sh' >> ~/.bashrc
echo 'PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]\$(__git_ps1 \" (%s)\")\[\033[00m\]\$ "' >> ~/.bashrc

# Reload
source ~/.bashrc
```

### Option 3: Switch to Zsh with Oh-My-Zsh

For the best terminal experience with git integration:

```bash
# Install zsh
sudo apt-get install zsh git curl

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change default shell to zsh
chsh -s $(which zsh)

# Log out and back in for changes to take effect
```

Oh-My-Zsh comes with:
- Git branch/status in prompt
- Syntax highlighting
- Auto-completion
- Tons of plugins

Edit `~/.zshrc` to customize themes:

```bash
# Popular themes for old hardware (fast)
ZSH_THEME="robbyrussell"  # Default, clean
# ZSH_THEME="simple"      # Minimal
# ZSH_THEME="agnoster"    # Fancy (requires powerline fonts)
```

### Git Aliases for Better Workflow

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
```

---

## Claude Code Editor

Claude Code is a modern AI-powered code editor. However, running it on i386 Debian may have limitations.

### System Requirements Check

Claude Code (being based on VS Code) typically requires:
- 64-bit architecture (x64 or ARM64)
- Minimum 1GB RAM (2GB+ recommended)
- Modern processor

**Important:** Claude Code likely **will not run on i386** architecture as it requires 64-bit support.

### Alternatives for i386

If Claude Code doesn't work on your i386 machine, consider these alternatives:

#### 1. **Emacs with AI Integration**

Use Emacs with command-line AI tools:
- Install Emacs (lightweight, works on i386)
- Use curl to call AI APIs from within Emacs

#### 2. **Vim/Neovim with Plugins**

```bash
# Install Neovim
sudo apt-get install neovim

# Or classic Vim
sudo apt-get install vim
```

Both are extremely lightweight and work perfectly on i386.

#### 3. **Geany (Lightweight GUI IDE)**

```bash
sudo apt-get install geany
```

Geany is a lightweight IDE that works well on old hardware:
- Syntax highlighting
- Auto-completion
- Project management
- Very low resource usage

#### 4. **VS Code Alternative: Code-OSS (if 64-bit)**

If your system is actually 64-bit (not i386):

```bash
# Check architecture
uname -m

# If x86_64, you can try VSCodium (open-source VS Code)
```

### Using Claude via Terminal

Instead of Claude Code, you can use Claude through the terminal:

#### Method 1: Anthropic CLI (if available)

```bash
# Install Node.js first
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Check if Claude CLI is available
npm install -g @anthropic-ai/claude-cli
```

#### Method 2: API via curl

Create a helper script `~/bin/ask-claude.sh`:

```bash
#!/bin/bash
# Ask Claude a question via API

API_KEY="your-api-key-here"
QUESTION="$*"

curl https://api.anthropic.com/v1/messages \
  -H "content-type: application/json" \
  -H "x-api-key: $API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d "{
    \"model\": \"claude-3-sonnet-20240229\",
    \"max_tokens\": 1024,
    \"messages\": [{\"role\": \"user\", \"content\": \"$QUESTION\"}]
  }"
```

Make executable:

```bash
chmod +x ~/bin/ask-claude.sh
```

Usage:

```bash
ask-claude.sh "How do I reverse a string in Python?"
```

---

## Recommended Setup for i386

Given the hardware limitations of i386, here's the optimal setup:

### Text Editors (in order of recommendation):
1. **Emacs-nox** - Powerful, lightweight terminal editor
2. **Neovim/Vim** - Ultra-lightweight, very fast
3. **Nano** - Simple, already installed
4. **Geany** - Lightweight GUI option

### Terminal:
1. **Bash with git-prompt** - Good balance of features and performance
2. **Zsh with Oh-My-Zsh** - More features, slightly heavier
3. **Enhanced xterm** - Keep using xterm, just enhance the prompt

### Development Workflow:
1. Use **Emacs** or **Vim** for editing
2. Use **git** from command line with aliases
3. Use **tmux** for terminal multiplexing (multiple terminals in one window)
4. Access Claude via web browser or API

### Installing Tmux (Highly Recommended)

```bash
sudo apt-get install tmux
```

Tmux allows multiple terminal sessions in one window:

```bash
# Start tmux
tmux

# Split horizontally: Ctrl+b then "
# Split vertically: Ctrl+b then %
# Switch panes: Ctrl+b then arrow keys
# New window: Ctrl+b then c
# Switch windows: Ctrl+b then number
```

---

## Quick Installation Script

See `10-install-enhancements.sh` for automated installation of these tools.

---

## Summary

**For i386 systems, the best setup is:**
- **Editor:** Emacs-nox or Vim
- **Terminal:** Bash with git-prompt or Zsh
- **Multiplexing:** Tmux
- **Git:** Command-line with aliases
- **AI Access:** Web browser or API calls

This gives you a powerful development environment that runs smoothly on older hardware!
