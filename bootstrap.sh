#!/bin/bash
set -e

echo "--- 1. SYSTEM LAYER (Apt fixes) ---"
sudo apt update
sudo apt install -y zsh gnome-keyring libsecret-1-dev fuse-overlayfs podman git curl build-essential

echo "--- 2. SHELL LAYER (Zsh + OMZ) ---"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "--- 3. PACKAGE MANAGER (Homebrew) ---"
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo "--- 4. DEVELOPER STACK (Brewfile) ---"
if [ -f "Brewfile" ]; then
    brew bundle --file=./Brewfile
else
    echo "No Brewfile found, skipping..."
fi

echo "--- 5. ROOTLESS PODMAN FIX ---"
if [ ! -f "/etc/subuid" ] || ! grep -q "$USER" /etc/subuid; then
    echo "$USER:100000:65536" | sudo tee -a /etc/subuid
    echo "$USER:100000:65536" | sudo tee -a /etc/subgid
fi
podman system migrate

echo "--- BOOTSTRAP COMPLETE ---"
