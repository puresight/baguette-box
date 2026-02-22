#!/bin/bash
set -e

source ./lib/functions.sh
if [ "$PLATFORM" == "linux" ]; then
    sudo apt update
fi

echo
echo "--- APT PACKAGE INSTALLS ---"
if [ "$PLATFORM" == "linux" ]; then
    # Add apt source packages.microsoft.com
    sudo apt install -y wget gpg zsh gnome-keyring libsecret-1-dev libsecret-tools seahorse fuse-overlayfs podman git curl jq build-essential software-properties-common
    #   unattended-upgrades apt-listchanges
    # sudo dpkg-reconfigure unattended-upgrades
    # Download the key to the standard location the package expects
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
    # Create the source file using the standard path
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    # Clean up any existing conflicting files before updating
    sudo rm -f /etc/apt/keyrings/packages.microsoft.gpg
    sudo apt update
else
    echo "Skipping APT on $PLATFORM"
fi

echo
echo "--- ROOTLESS PODMAN FIX ---"
if [ "$PLATFORM" == "linux" ]; then
    # The Problem: By default, a Linux user only has one UID (yours). To run a container, Podman needs to pretend to be "root" inside the container while remaining a "normal user" outside. It does this by mapping a range of UIDs from the host to the container.
    # The Fix: By adding $USER:100000:65536 to /etc/subuid and subgid, you are granting your user permission to "own" 65,536 subordinate IDs.
    if [ ! -f "/etc/subuid" ] || ! grep -q "$USER" /etc/subuid; then
        echo "Defining a range of subordinate user IDs that the standard user account is permitted to use for User Namespaces"
        echo "$USER:100000:65536" | sudo tee -a /etc/subuid
        echo "Defining a range of subordinate group IDs that the standard user account is permitted to use for User Namespaces"
        echo "$USER:100000:65536" | sudo tee -a /etc/subgid
        echo "See https://github.com/containers/podman/blob/main/troubleshooting.md"
        echo "Applying any changes to the current session"
    fi
    podman --version
    # Refresh the runtime to recognize these new mappings. This prevents the common ERRO[0000] user namespaces are not enabled error.
    podman system migrate
else
    echo "Skipping Podman fix on $PLATFORM"
fi

# echo
# echo "--- GO language ---"
# Add APT source for Debian Backports. Backports are deactivated by default to prevent accidental upgrades. You must explicitly tell APT to use the backports target:
# echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
# sudo apt install -t bookworm-backports golang-go -y
# ^^^ Failed: because version updates are sloth slow
#
# This is a little better (just enterprisey):
# sudo add-apt-repository ppa:longsleep/golang-backports -y
# sudo apt update
# sudo apt install golang-go -y

echo
echo "--- RUST ---"
if command -v rustup &> /dev/null; then
    rustup update
else
    # Rust APT dependencies: build-essential curl
    # We download and run the rustup-init script non-interactively
    #   -sSf: Silent, show errors, fail on server errors
    #   -y: Auto-confirm default installation options
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

echo
echo "--- JAVA ---"
echo "Installing Microsoft OpenJDK version 21..."
source lib/java.sh
INSTALL_MS_OPENJDK 21
# echo "Installing Microsoft OpenJDK versions 17, 21, 25 ..."
# INSTALL_MS_OPENJDK 21 17 25
echo
java -version

echo
echo "--- HOMEBREW INSTALL ---"

if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Setting up environment"
if [ "$PLATFORM" == "linux" ]; then
    if [ -d "/home/linuxbrew/.linuxbrew" ]; then
        BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
    elif [ -d "$HOME/.linuxbrew" ]; then
        BREW_PATH="$HOME/.linuxbrew/bin/brew"
    fi
elif [ "$PLATFORM" == "macos" ]; then
    if [ -f "/opt/homebrew/bin/brew" ]; then
        BREW_PATH="/opt/homebrew/bin/brew"
    elif [ -f "/usr/local/bin/brew" ]; then
        BREW_PATH="/usr/local/bin/brew"
    fi
fi

if [ -n "$BREW_PATH" ]; then
    eval "$($BREW_PATH shellenv)"
    echo "Persisting in ~/.zprofile"
    if ! grep -q "shellenv" "$HOME/.zprofile"; then
        (echo; echo "eval \"\$($BREW_PATH shellenv)\"") >> "$HOME/.zprofile"
    fi
fi

echo
echo "--- HOMEBREW Brewfile ---"
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
echo "--- ENVIRONMENT ---"
if [ "$PLATFORM" == "linux" ]; then
    if command -v hostnamectl &> /dev/null; then
        hostnamectl
    else
        cat /etc/os-release
    fi
elif [ "$PLATFORM" == "macos" ]; then
    sw_vers
fi

echo
echo "--- CURRENT VERSIONS ---"
echo "$(brew --version | head -n 1)"
echo "Node $(node -v)"
echo "npm $(npm -v)"
echo "$(uv --version)"
# echo "$(rustup --version | head -n 1)"
echo "$(rustc --version)"
echo "$(cargo --version)"
echo "$(go version)"
echo "$(javac -version)"
