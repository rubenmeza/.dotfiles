# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package that mirrors `$HOME` structure. Targets both macOS and Arch Linux (Omarchy).

## Deployment

Stow a package to symlink it into `$HOME`:
```bash
stow --target="$HOME" <package>    # e.g. stow --target="$HOME" nvim
stow --adopt --target="$HOME" <package>  # adopt existing files
```

The `setup-omarchy.sh` script handles Arch/Omarchy setup: installs pacman/AUR packages, removes default nvim config, then stows `nvim` and `omarchy` packages.

## Architecture

- **Platform-specific configs**: `zsh_mac/` and `zsh_ubuntu/` are separate stow packages — only stow the one matching the current OS.
- **Neovim**: Entry point is `nvim/.config/nvim/init.lua` → loads `polluelo` module. Plugin configs live in `lua/polluelo/lazy/`. Uses Lazy.nvim as plugin manager. Format-on-save via conform.nvim. Leader-based LSP keymaps are set in `lua/polluelo/init.lua` via `LspAttach` autocmd.
- **Omarchy overrides**: The `omarchy/` package contains Hyprland and Waybar customizations that layer on top of the base Omarchy desktop. Key remaps: workspaces use `ALT+1-9` instead of `SUPER`, window focus uses `ALT+hjkl`, terminal opens with `ALT+RETURN`, close window is `ALT+Q`.
- **Git**: Conditional gitconfig — `~/code/work/` subtree uses a separate `.gitconfig` for work identity.
- **Custom scripts**: `bin/.local/bin/` has `tmux-sessionizer` (fuzzy project switcher) and `tmux-cht` (cheat sheet lookup). Environment variables in `bin/.local/envars`.
