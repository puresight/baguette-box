#!/bin/bash
set -e

# Load platform detection
source ./lib/platforms.sh

# Function to handle APT package installation
install_apt_packages() {
    local platform="$1"
    if [ "$platform" == "linux" ]; then
        echo "--- APT ---"
        # Update & upgrade
        sudo apt update -qq && sudo apt upgrade -y
        sudo apt autoremove -y

        # Add all APT sources for Microsoft packages
        source lib/apt.sh

        # Now install APT packages for this bootstrap
        sudo apt install -y software-properties-common build-essential git  \
            curl wget jq vim tmux zsh dnsutils htop ripgrep ca-certificates \
            pkg-config libssl-dev unzip zip xz-utils p7zip-full gpg \
            gnome-keyring libsecret-1-dev libsecret-tools \
            seahorse fuse-overlayfs podman \
            awscli
        # TODO for servers? learn what,why, if we should do this: sudo dpkg-reconfigure unattended-upgrades apt-listchanges
    else
        echo "Skipping APT on $platform"
    fi
}

# Function to handle UV installation
install_uv() {
    local platform="$1"
    echo
    echo "--- UV ---"
    if [ "$platform" == "linux" ]; then
        if ! command -v uv; then
            curl -LsSf https://astral.sh/uv/install.sh | sh
            grep -qF 'export UV_NO_BUILD=1' ~/.zshrc || echo 'export UV_NO_BUILD=1' >> ~/.zshrc
        else
            echo "$(uv --version) was already installed."
            uv self update
        fi
        uv python install
    else
        echo "Not yet supported on $platform"
    fi
}

# Function to handle MISE installation per https://mise.jdx.dev/installing-mise.html
install_mise() {
    local platform="$1"
    local shell="$2"
    echo
    echo "--- MISE ---"
    if [ "$platform" == "linux" ]; then
        if ! command -v mise; then
            # Install mise and add activation to ~/.zshrc
            curl https://mise.run/$shell | sh
        else
            mise v
            mise up
        fi
    else
        echo "Not yet supported on $platform"
    fi
}

# Function to handle GOOSE installation
install_goose() {
    local platform="$1"
    echo
    echo "--- GOOSE ---"
    if [ "$platform" == "linux" ]; then
        if ! command -v goose --version &> /dev/null; then
            curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | CONFIGURE=false bash
        else
            echo "Goose $(goose --version) was already installed."
        fi
    else
        echo "Not yet supported on $platform"
    fi
}

# Function to handle .NET installation
install_dotnet() {
    local platform="$1"
    echo
    echo "--- .NET ---"
    if [ "$platform" == "linux" ]; then
        for arg in "$@"; do
            if [ "$arg" != "$platform" ]; then
                echo "Installing .NET SDK $arg..."
                sudo apt install -y "dotnet-sdk-$arg.0"
            fi
        done
        sudo apt install -y powershell
    else
        echo "Not yet supported on $platform"
    fi
}

# Function to handle shell configuration
configure_shell() {
    local platform="$1"
    echo
    echo "--- SHELL ---"
    export PATH=$PATH:~/.local/bin
    
    if [ "$platform" == "linux" ]; then
        # change shell to zsh
        sudo chsh -s $(which zsh) $USER

        # Posh exists? upgrade it! No posh, install it.
        if command -v oh-my-posh &> /dev/null; then
            oh-my-posh upgrade
        else
            curl -s https://ohmyposh.dev/install.sh | bash -s
        fi

        # Posh's config persists in .zshrc
        if ! grep -q "oh-my-posh init zsh" "$HOME/.zshrc"; then
            echo 'eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/pure.omp.json)"' >> "$HOME/.zshrc"
            echo "Persisting in ~/.zshrc"
        fi

        # Configure Posh for Powershell
        pwsh -NoProfile -File ./bootstrap.ps1

    elif [ "$platform" == "macos" ]; then
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
}

# Function to handle Podman configuration
configure_podman() {
    local platform="$1"
    echo
    echo "--- PODMAN ---"
    if [ "$platform" == "linux" ]; then
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
        echo "Skipping Podman fix on $platform"
    fi
}

# Function to handle Rust installation
install_rust() {
    local platform="$1"
    echo
    echo "--- RUST ---"
    if command -v rustup &> /dev/null; then
        rustup update

        # TODO investigate re-enabling this; it compiled from source 157 packages (too much) last time
        # cargo install-update -a
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
}

# Function to handle Java installation
install_java() {
    local platform="$1"
    local java_version="$2"
    echo
    echo "--- JAVA ---"
    source lib/java.sh
    echo "Installing Microsoft OpenJDK version $java_version..."
    INSTALL_MS_OPENJDK $java_version
    # The first JDK version will be made the active one;
    # multiple are possible for example INSTALL_MS_OPENJDK 21 17 25
    echo
    java -version
}

# Function to handle Homebrew installation
install_homebrew() {
    local platform="$1"
    echo
    echo "--- HOMEBREW ---"

    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "$(brew --version | head -n 1) already installed."
    fi
    echo "Setting up environment"
    local BREW_PATH=""
    if [ "$platform" == "linux" ]; then
        if [ -d "/home/linuxbrew/.linuxbrew" ]; then
            BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
        elif [ -d "$HOME/.linuxbrew" ]; then
            BREW_PATH="$HOME/.linuxbrew/bin/brew"
        fi
    elif [ "$platform" == "macos" ]; then
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
}

# Function to display environment information
display_environment() {
    local platform="$1"
    echo
    echo "--- ENVIRONMENT ---"
    if [ "$platform" == "linux" ]; then
        if command -v hostnamectl &> /dev/null; then
            hostnamectl
        else
            cat /etc/os-release
        fi
    elif [ "$platform" == "macos" ]; then
        sw_vers
    fi
}

# Function to display current versions
display_versions() {
    echo
    echo "--- CURRENT VERSIONS ---"
    echo "$(uv --version)"
    echo "$(python3 --version)"
    echo "$(rustc --version)"
    echo "$(cargo --version)"
    echo "$(go version)"
    echo "$(javac -version)"
    echo "dotnet $(dotnet --version)"
    echo "pwsh $(pwsh --version)"
    echo "Node $(node -v)"
    echo "npm $(npm -v)"
}

# Main execution
install_apt_packages "$PLATFORM"
install_uv          "$PLATFORM"
install_mise        "$PLATFORM" zsh
install_goose       "$PLATFORM"
install_dotnet      "$PLATFORM" 10
configure_shell     "$PLATFORM"
configure_podman    "$PLATFORM"
install_rust        "$PLATFORM"
install_java        "$PLATFORM" 21
install_homebrew    "$PLATFORM"
display_environment "$PLATFORM"
display_versions
