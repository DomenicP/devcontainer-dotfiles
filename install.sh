#!/usr/bin/env bash

set -eu

main() {
    check_compatibility
    install_packages
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
    # software-properties-common is required for add-apt-repository
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends software-properties-common
    sudo add-apt-repository -y ppa:fish-shell/release-4

    # Install packages
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends \
        bat \
        fd-find \
        fish \
        fzf \
        jq \
        ripgrep \
        tree

    # Add symlinks
    sudo ln -sf "$(which batcat)" /usr/local/bin/cat
    sudo ln -sf "$(which fdfind)" /usr/local/bin/fd

    # Add shell hooks
    mkdir -p ~/.config/fish
    echo "direnv hook fish | source" >>~/.config/fish/config.fish
}

main "$@"
