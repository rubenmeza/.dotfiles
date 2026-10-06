# .dotfiles

Personal dotfiles for Arch Linux ([Omarchy](https://omarchy.org)), macOS and older Ubuntu/i3 setups, managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a stow package whose contents mirror `$HOME`, so stowing it symlinks the files into place.

## Usage

### Omarchy (Arch Linux)

```bash
git clone git@github.com:rubenmeza/.dotfiles.git ~/Dev/.dotfiles
cd ~/Dev/.dotfiles
./setup-omarchy.sh
```

`setup-omarchy.sh`:

1. Installs pacman packages (stow, neovim tooling, ripgrep/fd/fzf, tmux, go, rust, docker, claude-code, godot, …) and AUR packages (brave, chrome).
2. Removes unwanted defaults (LibreOffice, 1Password).
3. Backs up any existing configs that would conflict to `.backups/<timestamp>/` (git-ignored).
4. Stows `nvim omarchy bash tmux ghostty bin claude agents codex`.

### Single package

```bash
stow --target="$HOME" nvim             # symlink one package
stow --adopt --target="$HOME" nvim     # take over existing files instead of conflicting
stow -D --target="$HOME" nvim          # remove the symlinks
```

## Packages

### Omarchy / Linux desktop

| Package | Target | What it does |
|---|---|---|
| `omarchy` | `~/.config/hypr/bindings.lua`, `input.lua` | Hyprland overrides on top of Omarchy: workspaces on `ALT+1-0` (`ALT+SHIFT` to move windows), focus with `ALT+hjkl`, terminal on `ALT+RETURN`, close window with `ALT+Q`; key repeat delay and natural touchpad scrolling |
| `ghostty` | `~/.config/ghostty/config` | Ghostty terminal; follows the current Omarchy theme, CaskaydiaMono Nerd Font |
| `alacritty` | `~/.config/alacritty/alacritty.toml` | Alacritty terminal |
| `bash` | `~/.bashrc`, `~/.bash_profile` | Loads Omarchy's default bash rc, then adds Go/Cargo/`~/.local/bin` paths, `CTRL+F` → `tmux-sessionizer`, helpers, and sources `~/.bash_secrets` if present |

### Editor & terminal

| Package | Target | What it does |
|---|---|---|
| `nvim` | `~/.config/nvim` | Neovim config (see below) |
| `tmux` | `~/.config/tmux/tmux.conf` | Prefix `CTRL+Space` (`CTRL+B` also works), vi copy mode, `ALT+Enter` splits, `hjkl` pane navigation, `prefix q` to reload |
| `bin` | `~/.local/bin`, `~/.local/envars` | `tmux-sessionizer` (fuzzy project → tmux session), `tmux-cht` (cheat.sh lookup in tmux), `godot-nvim` (open Godot files in a running Neovim) |

### AI coding agents

| Package | Target | What it does |
|---|---|---|
| `agents` | `~/.agents/AGENTS.md` | Shared global rules for every coding agent (Claude Code, Codex, Cursor). Single source of truth. |
| `claude` | `~/.claude/` | Claude Code `CLAUDE.md` (imports the shared rules), `settings.json` (model, plugins, attribution) and the `deploy-do` skill for DigitalOcean App Platform deploys |
| `codex` | `~/.codex/AGENTS.md` | Codex entry point to the shared rules |

### Shell, git & ssh

| Package | Target | What it does |
|---|---|---|
| `zsh` | `~/.zshrc`, `~/.zsh_profile` | Generic zsh + oh-my-zsh config |
| `zsh_mac` / `zsh_ubuntu` | same | Platform variants; stow only the one that matches the OS |
| `git` | `~/.gitconfig`, `~/code/work/.gitconfig` | Personal identity, `nvim` as editor; repos under `~/code/work/` automatically use the work identity |
| `ssh` | `~/.ssh/config` | Host aliases for personal and work GitHub keys |

### macOS

| Package | Target | What it does |
|---|---|---|
| `yabai` | `~/.config/yabai/yabairc` | Tiling window manager |
| `skhd` | `~/.config/skhd/skhdrc` | Hotkey daemon for yabai |
| `sketchybar` | `~/.config/sketchybar/` | Menu bar with battery, clock, volume, Wi-Fi, spaces and front-app plugins |

### Legacy Ubuntu

| Package | Target | What it does |
|---|---|---|
| `i3` | `~/.config/i3/`, `~/.config/i3status/` | i3 window manager and status bar |
| `redshift` | `~/.config/redshift.conf` | Screen color temperature |

## Neovim

Entry point `init.lua` loads the `polluelo` module:

- `lua/polluelo/set.lua`: editor options
- `lua/polluelo/remap.lua`: keymaps
- `lua/polluelo/init.lua`: autocmds and `LspAttach` leader keymaps
- `lua/polluelo/lazy/`: one file per plugin, managed by [lazy.nvim](https://github.com/folke/lazy.nvim) with versions pinned in `lazy-lock.json`

Plugins:

- **LSP and formatting:** nvim-lspconfig, mason, conform.nvim (format on save), fidget
- **Navigation:** telescope, harpoon, undotree
- **Syntax:** treesitter, treesitter-context
- **UI:** tokyonight, lualine, which-key, trouble, gitsigns
- **Other:** copilot.lua, peek.nvim (Markdown preview), golf

To update plugins, run `:Lazy sync` and commit `lazy-lock.json`.

## Notes

- **Secrets:** API tokens go in `~/.bash_secrets`, which is never committed.
- **Omarchy updates:** Omarchy keeps `~/.config/hypr/` as a real directory. Only individual files are stowed into it, so Omarchy updates keep working.
- **Agent rules:** edit them in `agents/.agents/AGENTS.md`. After changing them, paste them again into Cursor.
