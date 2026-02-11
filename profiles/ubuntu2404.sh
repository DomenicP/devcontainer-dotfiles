#!/usr/bin/env bash

set -eu

FZF_VERSION=v0.67.0
FZF_HOME="$HOME/.fzf"

# Bind mounts can end up creating intermediate directories owned by root. Fix
# ownership of key directories non-recursively so we don't mess with
# permissions on files mounted from the host.
MY_DIRECTORIES=(
    "$HOME/.config"
    "$HOME/.local"
    "$HOME/.local/share"
)
for my_dir in "${MY_DIRECTORIES[@]}"; do
    if [ -d "$my_dir" ]; then
        sudo chown "$(id -u):$(id -g)" "$my_dir"
    fi
done

# Add PPA for Fish 4.x
# software-properties-common is required for add-apt-repository
sudo apt-get update
sudo apt-get install -y --no-install-recommends software-properties-common
sudo add-apt-repository -y ppa:fish-shell/release-4

# Install APT packages
sudo apt-get update
sudo apt-get install -y --no-install-recommends \
    bat \
    direnv \
    fd-find \
    fish \
    jq \
    ripgrep \
    tmux \
    tree \
    yq

# Install a newer version of fzf
git clone --depth 1 --branch $FZF_VERSION \
    https://github.com/junegunn/fzf.git "$FZF_HOME"
"$FZF_HOME/install" --all

# Install Starship
curl -sS https://starship.rs/install.sh | sudo sh -s -- --yes

# Add shell hooks
mkdir -p "$HOME/.config/fish"
cat << EOF >> "$HOME/.config/fish/config.fish"
direnv hook fish | source
starship init fish | source
EOF

# Add symlinks
sudo ln -sf "$(which batcat)" /usr/local/bin/bat
sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
