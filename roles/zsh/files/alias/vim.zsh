#!/usr/bin/env zsh

if command -v nvim &>/dev/null; then
  alias v='nvim'
elif command -v vim &>/dev/null; then
  alias v='vim'
elif command -v vi &>/dev/null; then
  alias v='vi'
else
  echo "No vi/vim/nvim found!" >&2
fi