#!/usr/bin/env zsh

# FIXME: After development finished, this path has to be adjusted
DOTFILES_DIR="$HOME/Developer/zen-dotfiles"

# Function to handle tab completion
_complete_tags() {
    local cur_word tags_list
    cur_word="${words[CURRENT]}"

    # Find directories in the specified directory and store them in tags_list
    tags_list=($(find "$DOTFILES_DIR/roles" -maxdepth 1 -type d -exec basename {} \;))

    # Add -t and --skip-tags as options
    if [[ "${cur_word}" == -* ]]; then
        compadd -W "-t --skip-tags"
    else
        # Add directories as completion options
        compadd "${tags_list[@]}"
    fi
}

dotfiles() {
  ansible-playbook "$DOTFILES_DIR/main.yml" "$@" --ask-become-pass
}

cdrole() {
  local role_name="$1"
  local role_path="$DOTFILES_DIR/roles/${role_name}"

  if [[ -d "$role_path" ]]; then
    cd "$role_path"
  else
    echo "Role '$role_name' not found at $role_path"
    return 1
  fi
}

# Register the completion function with compdef
compdef _complete_tags dotfiles
compdef _complete_tags cdrole
