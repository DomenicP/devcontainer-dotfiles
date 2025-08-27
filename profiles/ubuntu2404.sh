#!/usr/bin/env bash

set -eu

# Add PPA for Fish 4.x
# software-properties-common is required for add-apt-repository
sudo apt-get update
sudo apt-get install -y --no-install-recommends software-properties-common
sudo add-apt-repository -y ppa:fish-shell/release-4

# Install APT packages
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    bat \
    fd-find \
    fish \
    jq \
    ripgrep \
    tmux \
    tree

# Install a newer version of fzf
git clone --depth 1 --branch v0.65.1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Install Starship
curl -sS https://starship.rs/install.sh | sudo sh -s -- --yes

# Add shell hooks
mkdir -p ~/.config/fish
cat <<EOF >>~/.config/fish/config.fish
direnv hook fish | source
starship init fish | source
EOF

# Add symlinks
sudo ln -sf "$(which batcat)" /usr/local/bin/bat
sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
