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
    ripgrep
    fd
    tree-sitter
    tree-sitter-cli
    npm
    go
    rustup
)

echo "==> Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

AUR_PKGS=(
    brave-bin
)

echo "==> Installing AUR packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# ── Remove default omarchy lazyvim config ─────────────────────────
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim/init.lua" ]; then
    echo "==> Removing default nvim config..."
    rm -rf "$HOME/.config/nvim"
fi

# ── Stow dotfiles ────────────────────────────────────────────────
echo "==> Stowing nvim config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" --adopt nvim

echo "==> Stowing omarchy config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" --adopt omarchy

echo "==> Done! Restart your terminal or reload your config."
