#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Updating system packages..."
# sudo pacman -Syu --noconfirm

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
    luarocks
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

# ── Backup and remove configs that conflict with stow ────────────
BACKUP_DIR="$DOTFILES_DIR/.backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

backup_and_remove() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local rel="${target#$HOME/}"
        mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
        echo "==> Backing up $target..."
        cp -a "$target" "$BACKUP_DIR/$rel"
        rm -rf "$target"
    fi
}

# Full directory configs (stow owns the entire dir)
for dir in nvim tmux; do
    backup_and_remove "$HOME/.config/$dir"
done

# Omarchy owns ~/.config/hypr/ and ~/.config/waybar/ as real directories,
# so we only remove the specific files that stow will manage (not the whole dirs).
for file in hypr/bindings.conf hypr/input.conf waybar/config.jsonc; do
    backup_and_remove "$HOME/.config/$file"
done

# Bash dotfiles
for file in "$HOME/.bashrc" "$HOME/.bash_profile"; do
    backup_and_remove "$file"
done

# Claude config files
for file in "$HOME/.claude/settings.json" "$HOME/.claude/skills/deploy-do/SKILL.md"; do
    backup_and_remove "$file"
done

echo "==> Backups saved to $BACKUP_DIR"

# ── Stow dotfiles ────────────────────────────────────────────────
echo "==> Stowing nvim config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" nvim

echo "==> Stowing omarchy config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" omarchy

echo "==> Stowing bash config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" bash

echo "==> Stowing tmux config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" tmux

echo "==> Stowing bin scripts..."
stow --dir="$DOTFILES_DIR" --target="$HOME" bin

echo "==> Stowing claude config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" claude

echo "==> Done! Restart your terminal or reload your config."
