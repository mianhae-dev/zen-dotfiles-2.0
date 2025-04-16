#!/usr/bin/env zsh

add_to_path() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

add_to_path_front() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

die () {
    echo >&2 "$@"
    exit 1
}
