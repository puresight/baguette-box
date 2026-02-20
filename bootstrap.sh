#!/bin/bash
set -e
OS_TYPE=$(uname -s)

echo
echo "--- BOOTSTRAP START ---"
# update
if [ "$OS_TYPE" == "Linux" ]; then
    sudo apt update
fi

echo
echo "--- APT PACKAGE INSTALLS ---"
if [ "$OS_TYPE" == "Linux" ]; then
    # Add apt source packages.microsoft.com
    sudo apt install -y wget gpg
    # Download the key to the standard location the package expects
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
    # Create the source file using the standard path
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    # Clean up any existing conflicting files before updating
    sudo rm -f /etc/apt/keyrings/packages.microsoft.gpg
    # Update
    sudo apt update
    # Install other stuff
    sudo apt install -y zsh gnome-keyring libsecret-1-dev libsecret-tools seahorse fuse-overlayfs podman git curl build-essential
else
    echo "Skipping APT on $OS_TYPE"
fi

echo
echo "--- HOMEBREW SETUP ---"

if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Setting up environment"
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
elif [ -d "$HOME/.linuxbrew" ]; then
    BREW_PATH="$HOME/.linuxbrew/bin/brew"
fi
eval "$($BREW_PATH shellenv)"

echo "Persisting in ~/.zprofile"
if ! grep -q "shellenv" "$HOME/.zprofile"; then
    (echo; echo "eval \"\$($BREW_PATH shellenv)\"") >> "$HOME/.zprofile"
fi

echo
echo "--- INSTALL HOMEBREW Brewfile ---"
brew bundle --file=./Brewfile

echo
echo "--- SHELL CONFIGURATION ---"
sudo chsh -s $(which zsh) $USER
if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi
echo "Shell $SHELL ($($SHELL --version | head -n 1))"
echo "Prompt $(starship --version | head -n 1)"
echo "Persisting in ~/.zshrc"

echo
echo "--- ROOTLESS PODMAN FIX ---"
if [ ! -f "/etc/subuid" ] || ! grep -q "$USER" /etc/subuid; then
    echo "Defining a range of subordinate user IDs that the standard user account is permitted to use for User Namespaces"
    echo "$USER:100000:65536" | sudo tee -a /etc/subuid
    echo "Defining a range of subordinate group IDs that the standard user account is permitted to use for User Namespaces"
    echo "$USER:100000:65536" | sudo tee -a /etc/subgid
    echo "See https://github.com/containers/podman/blob/main/troubleshooting.md"
    echo "Applying any changes to the current session"
fi
podman --version
podman system migrate

echo
echo "--- CURRENT VERSIONS ---"
echo "Brew: $(brew --version | head -n 1)"
echo "Node: $(node -v)"
echo "UV: $(uv --version)"
if command -v rustc &> /dev/null; then
    echo "Rust: $(rustc --version)"
elif command -v rustup &> /dev/null; then
    echo "Rustup: $(rustup --version | head -n 1)"
else
    echo "Rust: Not installed"
fi
echo "Go: $(go version)"
