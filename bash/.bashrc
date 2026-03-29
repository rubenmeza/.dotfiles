# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Omarchy defaults
source ~/.local/share/omarchy/default/bash/rc

# Env
export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/go
export GIT_EDITOR=nvim
export DOTFILES=$HOME/.dotfiles

PATH=$HOME/.local/bin:$PATH
PATH=$HOME/.cargo/bin:$PATH
PATH=$HOME/go/bin:$PATH

# Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Tmux sessionizer
bind -x '"\C-f": tmux-sessionizer' 2>/dev/null

# Utilities
catr() {
    tail -n "+$1" $3 | head -n "$(($2 - $1 + 1))"
}

validateYaml() {
    python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' < $1
}

# Local secrets (API tokens, etc.) — not tracked in git
[ -f ~/.bash_secrets ] && source ~/.bash_secrets
