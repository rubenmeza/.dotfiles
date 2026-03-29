# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Load profile
source ~/.zsh_profile

# NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Local secrets (API tokens, etc.) — not tracked in git
[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

# Omarchy envs (zsh-compatible parts only)
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi
export OMARCHY_PATH=$HOME/.local/share/omarchy
PATH=$OMARCHY_PATH/bin:$PATH

# Aliases
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='$EDITOR "$(ff)"'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='opencode'
alias cx='printf "\033[2J\033[3J\033[H" && claude --allow-dangerously-skip-permissions'
alias d='docker'
alias t='tmux attach || tmux new -s Work'
n() { if [ "$#" -eq 0 ]; then command nvim . ; else command nvim "$@"; fi; }

alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

open() { xdg-open "$@" >/dev/null 2>&1 & }

# Zoxide (zsh-native integration)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# FZF (zsh-native keybindings)
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
