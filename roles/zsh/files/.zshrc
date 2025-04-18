is_ssh_session() {
  [[ -n "$SSH_CONNECTION" || -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]
}

if is_ssh_session; then
  # REASON: When sshing via ghostty, the remote terminal borks,
  # so we need to set TERM to xterm-256color
  export TERM=xterm-256color
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"
zinit load atuinsh/atuin

# ZSH plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# ZSH snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aliases

autoload -Uz compinit && compinit

# source of shell functions must be after compinit
# REASON: some shell functions use cmpdeff, which is being loaded by compinit
for type in "var" "function" "alias"; do
  dir="${HOME}/.config/zsh/${type}"
  [ -d "$dir" ] || continue
  for file in "$dir"/*; do
    [ -f "$file" ] && source "$file"
  done
done

add_to_path "$HOME/.local/bin"
add_to_path "/opt/homebrew/bin"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
