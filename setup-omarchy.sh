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
    fzf
    tmux
    tree-sitter
    tree-sitter-cli
    npm
    go
    rust
    zsh
)

echo "==> Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

AUR_PKGS=(
    brave-bin
)

echo "==> Installing AUR packages..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# ── Install oh-my-zsh ────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "==> Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── Change default shell to zsh ──────────────────────────────────
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "==> Changing default shell to zsh..."
    chsh -s "$(which zsh)"
fi

# ── Remove default configs that conflict with stow ───────────────
for dir in nvim ghostty tmux; do
    target="$HOME/.config/$dir"
    if [ -d "$target" ] && [ ! -L "$target" ]; then
        echo "==> Removing default $dir config..."
        rm -rf "$target"
    fi
done

# Remove oh-my-zsh generated .zshrc so stow can replace it
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "==> Removing oh-my-zsh default .zshrc..."
    rm -f "$HOME/.zshrc"
fi

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

echo "==> Stowing zsh config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" zsh

echo "==> Stowing tmux config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" tmux

echo "==> Stowing bin scripts..."
stow --dir="$DOTFILES_DIR" --target="$HOME" bin

echo "==> Stowing claude config..."
stow --dir="$DOTFILES_DIR" --target="$HOME" claude

echo "==> Done! Restart your terminal or reload your config."
