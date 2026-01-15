# .dotfiles

Personal dotfiles configuration repository for managing development environment settings across macOS and Ubuntu systems.

## Overview

This repository contains configuration files (dotfiles) for various development tools and applications. The configurations are organized by application/tool and designed to provide a consistent development environment across different machines.

## What's Included

### Terminal & Shell
- **Alacritty** - GPU-accelerated terminal emulator configuration with optimized font sizes for both macOS and Ubuntu
- **Tmux** - Terminal multiplexer with TokyoNight color scheme, vim-like pane navigation, and custom key bindings
- **Zsh** - Shell configurations for both macOS and Ubuntu with Oh-My-Zsh integration

### Window Management
- **i3** - Tiling window manager configuration for Linux (Ubuntu)
- **Yabai** - Tiling window management for macOS
- **skhd** - Simple hotkey daemon for macOS keyboard shortcuts
- **Sketchybar** - Custom macOS menu bar with plugins for battery, clock, volume, WiFi, and active application display

### Development Tools
- **Neovim** - Comprehensive text editor configuration with:
  - Lazy.nvim plugin manager
  - LSP (Language Server Protocol) support
  - Telescope fuzzy finder
  - Treesitter syntax highlighting
  - GitHub Copilot integration
  - Harpoon for quick file navigation
  - Undotree, Gitsigns, and more
- **Git** - Custom git configuration with conditional configs for work/personal projects

### Utilities
- **Redshift** - Screen color temperature adjustment
- **SSH** - SSH configuration files
- **Custom Scripts** - Located in `bin/.local/bin/`:
  - `tmux-sessionizer` - Quick tmux session management with fuzzy finding
  - `tmux-cht` - Tmux cheat sheet utility

## Structure

Each directory follows the standard dotfile structure, mimicking the home directory layout:
```
tool-name/
  └── .config/tool-name/
      └── config-files
```

Separate configurations are maintained for platform-specific differences:
- `zsh_mac/` - macOS-specific Zsh configuration
- `zsh_ubuntu/` - Ubuntu-specific Zsh configuration

## TODO

- [ ] Add ubuntu install script
- [ ] Add mac install script
- [x] Verify Alacritty font.size for ubuntu
- [x] Verify Alacritty font.size for mac
- [ ] Add relative path support to local/bin/tmux-sessionizer -> ~/.tmux-dir file
