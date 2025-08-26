#!/usr/bin/env bash

set -eu

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
