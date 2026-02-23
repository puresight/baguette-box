#!/bin/bash
set -e

source ./lib/platforms.sh

echo
echo "--- APT ---"
if [ "$PLATFORM" == "linux" ]; then
    # Update & upgrade
    sudo apt update -qq && sudo apt upgrade -y
    sudo apt autoremove -y

    # Add all APT sources for Microsoft packages
    source lib/apt.sh

    # Now install APT packages for this bootstrap
    sudo apt install -y software-properties-common build-essential git  \
        curl wget jq vim tmux zsh dnsutils htop ripgrep ca-certificates \
        unzip zip xz-utils p7zip-full gpg \
        gnome-keyring libsecret-1-dev libsecret-tools \
        seahorse fuse-overlayfs podman
    # TODO for servers? learn what,why, if we should do this: sudo dpkg-reconfigure unattended-upgrades apt-listchanges
else
    echo "Skipping APT on $PLATFORM"
fi

echo
echo "--- SHELL ---"
export PATH=$PATH:~/.local/bin
# Install Oh-My-Posh
if [ "$PLATFORM" == "linux" ]; then
    # change shell to zsh
    sudo chsh -s $(which zsh) $USER

    if command -v oh-my-posh &> /dev/null; then
        oh-my-posh upgrade
    else
        curl -s https://ohmyposh.dev/install.sh | bash -s
    fi
    if ! grep -q "oh-my-posh init zsh" "$HOME/.zshrc"; then
        echo 'eval "oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/jandedobbeleer.omp.json"' >> "$HOME/.zshrc"
        echo "Persisting in ~/.zshrc"
    fi

    # --- STARSHIP ---
    # TODO prune this dead code section; starship was removed
    # Install starship
    # if ! grep -q "starship init zsh" "$HOME/.zshrc"; then
    #     echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
    # fi
    # echo "Prompt $(starship --version | head -n 1)"
elif [ "$PLATFORM" == "macos" ]; then
    if command -v oh-my-posh &> /dev/null; then
        oh-my-posh upgrade
    else
        brew install jandedobbeleer/oh-my-posh/oh-my-posh
    fi
else
    echo "Unsupported platform."
fi
echo "Shell: $SHELL ($($SHELL --version | head -n 1))"
echo "Prompt: oh-my-posh $(oh-my-posh version)"

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
    cargo install-update -a
else
    # Rust APT dependencies: build-essential curl
    # We download and run the rustup-init script non-interactively
    #   -sSf: Silent, show errors, fail on server errors
    #   -y: Auto-confirm default installation options
    echo "Installing Rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo "Adding cargo-binstall"
    curl -L https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
    cargo binstall cargo-update --no-confirm
fi

echo
echo "--- JAVA ---"
source lib/java.sh
echo "Installing Microsoft OpenJDK versions: 21..."
# The first JDK version will be made the active one:
INSTALL_MS_OPENJDK 21
# multiple are possible for example INSTALL_MS_OPENJDK 21 17 25
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
