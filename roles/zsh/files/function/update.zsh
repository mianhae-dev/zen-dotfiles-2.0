#!/usr/bin/env zsh

update() {
    if [ "$(which PrivilegesCLI)" ]; then
        PrivilegesCLI --add
    fi

    if [ "$(which brew)" ]; then
        brew update
        brew upgrade

        # force reinstall cask if brew-cask-upgrade is available
        # see https://github.com/buo/homebrew-cask-upgrade
        if [ "$(brew cu --help)" ]; then
            brew cu --all
        fi;
    fi
}

