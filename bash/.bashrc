# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Omarchy defaults
# /etc/omarchy.conf is written by omarchy-dev-link. When absent, force the
# package default instead of preserving a stale inherited dev-link value before
# we decide which rc file to source.
if [[ -f /etc/omarchy.conf ]]; then
  source /etc/omarchy.conf
  export OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"
else
  export OMARCHY_PATH=/usr/share/omarchy
fi
source "$OMARCHY_PATH/default/bash/rc"

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

export NODE_OPTIONS=--max-old-space-size=24576
export PLAYWRIGHT_SKIP_DOWNLOAD=true
