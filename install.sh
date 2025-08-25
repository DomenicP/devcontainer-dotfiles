#!/usr/bin/env bash

set -eu

main() {
    check_compatibility
    install_packages
    set_default_shell
}

check_compatibility() {
    if [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        case "$DISTRIB_ID" in
        Ubuntu)
            case "$DISTRIB_RELEASE" in
            24.04) ;;
            *)
                echo "ERROR: Unsupported Ubuntu release: $DISTRIB_RELEASE"
                exit 1
                ;;
            esac
            ;;
        *)
            echo "ERROR: Unsupported distribution: $DISTRIB_ID"
            exit 1
            ;;
        esac
    else
        echo "ERROR: Could not determine distribution: /etc/lsb-release not found"
        exit 1
    fi
}

install_packages() {
    # Add PPA for Fish 4.x
    sudo add-apt-repository ppa:fish-shell/release-4
    sudo apt-get update
    sudo apt-get install -y \
        fd-find \
        fish \
        fzf \
        ripgrep

    # Add fd symlink
    sudo ln -s "$(which fdfind)" /usr/local/bin/fd
}

set_default_shell() {
    # Change the default shell to fish
    chsh -s "$(which fish)"
}

main "$@"
