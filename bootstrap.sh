#!/bin/bash
set -e

echo "--- BOOTSTRAP START ---"

echo
echo "--- SYSTEM LAYER (Apt fixes) ---"
sudo apt update
sudo apt install -y zsh gnome-keyring libsecret-1-dev libsecret-tools seahorse fuse-overlayfs podman git curl build-essential

echo
echo "--- PACKAGE MANAGER (Homebrew) ---"
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

echo
echo "--- DEVELOPER STACK (Brewfile) ---"
brew bundle --file=./Brewfile

echo "--- SHELL CONFIGURATION (zsh with Starship) ---"
sudo chsh -s $(which zsh) $USER
if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

echo
echo "--- ROOTLESS PODMAN FIX ---"
if [ ! -f "/etc/subuid" ] || ! grep -q "$USER" /etc/subuid; then
    echo "Defining a range of subordinate user IDs that the standard user account is permitted to use for User Namespaces"
    echo "$USER:100000:65536" | sudo tee -a /etc/subuid
    echo "Defining a range of subordinate group IDs that the standard user account is permitted to use for User Namespaces"
    echo "$USER:100000:65536" | sudo tee -a /etc/subgid
    echo "See https://github.com/containers/podman/blob/main/troubleshooting.md"
fi
echo "Applying any changes to the current session"
podman system migrate

echo
echo "--- VERSIONS ---"

echo "shell: " # TODO display shell name and version
echo "Starship: $(starship --version | head -n 1)"
echo "Brew: " # TODO display homebrew version
echo "Node: $(node -v)"
echo "UV: $(uv --version)"
echo "Rust: " # TODO display Rust name and version
echo "Go: $(go version)"

echo
echo "--- BOOTSTRAP END ---"
