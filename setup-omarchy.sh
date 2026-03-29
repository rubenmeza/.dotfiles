#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Updating system packages..."
sudo pacman -Syu --noconfirm

# ── Install packages ──────────────────────────────────────────────
PACMAN_PKGS=(
    stow
    base-devel
    git
    curl
    unzip
    wget
    ripgrep
    fd
    fzf
    tmux
    tree-sitter
    tree-sitter-cli
    npm
    deno
    go
    rust
    stylua
    lua-jsregexp
    docker
    docker-buildx
    docker-compose
    claude-code
    godot
)

echo "==> Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

AUR_PKGS=(
    brave-bin
    google-chrome
)

# ── Remove bloatware ─────────────────────────────────────────────
REMOVE_PKGS=(
    alacritty
    libreoffice-fresh
    1password-cli
    1password-beta
)

echo "==> Removing unwanted packages..."
for pkg in "${REMOVE_PKGS[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
        sudo pacman -Rns --noconfirm "$pkg"
    fi
done

echo "==> Installing AUR packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# ── Remove default configs that conflict with stow ───────────────
for dir in nvim ghostty tmux; do
    target="$HOME/.config/$dir"
    if [ -d "$target" ] && [ ! -L "$target" ]; then
        echo "==> Removing default $dir config..."
        rm -rf "$target"
    fi
done

# Remove default bash files so stow can replace them
for file in "$HOME/.bashrc" "$HOME/.bash_profile"; do
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        echo "==> Removing existing $file..."
        rm -f "$file"
    fi
done

# Remove existing claude config files (non-symlinks) so stow can manage them
for file in "$HOME/.claude/settings.json" "$HOME/.claude/skills/deploy-do/SKILL.md"; do
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        echo "==> Removing existing $file..."
        rm -f "$file"
    fi
done

# ── Stow dotfiles ────────────────────────────────────────────────
echo "==> Stowing nvim config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" nvim

echo "==> Stowing omarchy config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" omarchy

echo "==> Stowing ghostty config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" ghostty

echo "==> Stowing bash config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" bash

echo "==> Stowing tmux config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" tmux

echo "==> Stowing bin scripts..."
stow --dir="$DOTFILES_DIR" --target="$HOME" bin

echo "==> Stowing claude config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" claude

echo "==> Done! Restart your terminal or reload your config."
