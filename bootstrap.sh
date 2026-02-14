#!/bin/bash
set -e

echo "--- 1. SYSTEM LAYER (Apt fixes) ---"
sudo apt update
sudo apt install -y zsh gnome-keyring libsecret-1-dev fuse-overlayfs podman git curl build-essential

echo "--- 2. PACKAGE MANAGER (Homebrew) ---"
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Set up Brew environment
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
elif [ -d "$HOME/.linuxbrew" ]; then
    BREW_PATH="$HOME/.linuxbrew/bin/brew"
fi
eval "$($BREW_PATH shellenv)"

# Persist Brew in .zprofile
if ! grep -q "shellenv" "$HOME/.zprofile"; then
    (echo; echo "eval \"\$($BREW_PATH shellenv)\"") >> "$HOME/.zprofile"
fi

echo "--- 3. DEVELOPER STACK (Brewfile) ---"
brew install gcc
brew bundle --file=./Brewfile

echo "--- 4. SHELL CONFIGURATION (Starship) ---"
# Initialize Starship in .zshrc if not already there
if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

echo "--- 5. ROOTLESS PODMAN FIX ---"
if [ ! -f "/etc/subuid" ] || ! grep -q "$USER" /etc/subuid; then
    echo "$USER:100000:65536" | sudo tee -a /etc/subuid
    echo "$USER:100000:65536" | sudo tee -a /etc/subgid
fi
podman system migrate

echo "--- 6. VERIFICATION ---"
echo "Node version: $(node -v)"
echo "Go version:   $(go version)"
echo "UV version:   $(uv --version)"
echo "Starship:     $(starship --version | head -n 1)"
echo "Brew:         SUCCESS"

echo "--- BOOTSTRAP COMPLETE ---"
