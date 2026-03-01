#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# Dependencies:
#   - PLATFORM global variable
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# --- load library code ---
source "$SCRIPTROOT/lib/platforms.sh" || { echo "Error: lib/platforms.sh not found."; exit 1; }
source "$SCRIPTROOT/lib/apt.sh"
source "$SCRIPTROOT/lib/fonts.sh"
source "$SCRIPTROOT/lib/java.sh"
source "$SCRIPTROOT/lib/mc.sh"

# Function to display help information
print_help() {
    cat << EOF
Usage: ${0} [OPTIONS]

Options:
  -h, --help      Show this help message and exit
  -i, --install   Install all VS Code components (default)
EOF
#   -d, --dry-run   Zero mutations, but display what would be done
#   -u, --update    Install only minor updates
#   -g, --upgrade   Install major version upgrades

# Examples:
#   ${0}                    # Install all components
#   ${0} --dry-run          # Show what would be installed
#   ${0} --update           # Update minor versions
#   ${0} --upgrade          # Upgrade to major versions
}

# Function to handle APT package installation
install_apt_packages() {
    local apt_file="$1"
    if [ "$PLATFORM" == "linux" ]; then
        echo "--- APT $1 ---"

        sudo apt update -qq
        sudo apt autoremove -y
        add_apt_sources

        # Now install APT packages from file
        if [ -f "$apt_file" ]; then
            echo "Installing packages from $apt_file..."
            sudo apt install -y $(cat "$apt_file" | sed 's/#.*$//' | sed '/^[[:space:]]*$/d' | tr '\n' ' ')
        else
            echo "Error: file '$apt_file' not found" >&2
            exit 1
        fi
    else
        echo "Skipping APT on $PLATFORM"
    fi
}

# Function to handle UV installation
install_uv() {
    local shell="${1:-bash}"
    echo
    echo "--- UV ---"
    if [ "$PLATFORM" == "linux" ]; then
        if ! command -v uv; then
            curl -LsSf https://astral.sh/uv/install.sh | sh
            grep -qF 'export UV_NO_BUILD=1' ~/.${shell}rc || echo 'export UV_NO_BUILD=1' >> ~/.${shell}rc
        else
            echo "$(uv --version) was already installed for $shell"
            uv self update
        fi
        uv python install
    else
        echo "Not yet supported on $PLATFORM"
    fi
}

# Function to handle MISE installation per https://mise.jdx.dev/installing-mise.html
install_mise() {
    local shell="${1:-bash}"
    echo
    echo "--- MISE ---"
    if [ "$PLATFORM" == "linux" ]; then
        if ! command -v mise; then
            # Install mise and add activation to ~/.zshrc
            curl https://mise.run/$shell | sh
        else
            mise v
            mise up
        fi
    else
        echo "Not yet supported on $PLATFORM"
    fi
}

# Function to handle GOOSE installation
install_goose() {
    echo
    echo "--- GOOSE ---"
    if [ "$PLATFORM" == "linux" ]; then
        if ! command -v goose --version &> /dev/null; then
            curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | CONFIGURE=false bash
        else
            echo "Goose $(goose --version) was already installed."
        fi
    else
        echo "Not yet supported on $PLATFORM"
    fi
}

# Function to handle .NET installation
install_dotnet() {
    echo
    echo "--- .NET ---"
    if [ "$PLATFORM" == "linux" ]; then
        for arg in "$@"; do
            if [ "$arg" != "$PLATFORM" ]; then
                echo "Installing .NET SDK $arg..."
                sudo apt install -y "dotnet-sdk-$arg.0"
            fi
        done
        sudo apt install -y powershell
    else
        echo "Not yet supported on $PLATFORM"
    fi
}

# Function to handle shell configuration
configure_shell() {
    local shell="${1:-bash}"
    echo
    echo "--- SHELL ---"
    export PATH=$PATH:~/.local/bin
    
    if [ "$PLATFORM" == "linux" ]; then
        # change shell
        sudo chsh -s $(which $shell) $USER

        # Posh exists? upgrade it! No posh, install it.
        if command -v oh-my-posh &> /dev/null; then
            oh-my-posh upgrade
        else
            curl -s https://ohmyposh.dev/install.sh | bash -s
        fi

        # Posh's config persists in shell's .rc file
        if ! grep -q "oh-my-posh init $shell" "$HOME/.${shell}rc"; then
            echo 'eval "$(oh-my-posh init $shell --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/pure.omp.json)"' >> "$HOME/.${shell}rc"
            echo "Persisting in ~/.${shell}rc"
        fi

        # Configure Posh for Powershell
        echo "pwsh $(pwsh --version)" 
        pwsh -NoProfile -File ./bootstrap.ps1

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
}

# Function to handle Podman configuration
configure_podman() {
    echo
    echo "--- PODMAN ---"
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
        echo "Fix not yet supported on $PLATFORM"
    fi
}

# Function to handle Rust installation
install_rust() {
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
install_storage_tools() {
    echo
    echo "--- STORAGE TOOLS ---"
    rclone --version

    local current_mc=$(command -v mc)
    local update_every_days=90          # Policy Constant for Update

    # if 'mc' is completely missing...
    if [ -z "$current_mc" ]; then
        install_minio_client "$@"

    # if 'mc' is older than 90 days (+90)...
    #   'find' returns the filename only if it matches the age criteria
    elif [ -n "$(find "$current_mc" -mtime +$update_every_days)" ]; then
        echo "MinIO Client is older than $update_every_days days. Updating..."
        install_minio_client

    else
        echo "MinIO Client (mc) is installed and up-to-date."
    fi
}

# Function to handle Java installation
install_flatpak() {
    local remote_name="${1:-flathub}"
    local remote_url="${2:-'https://dl.flathub.org/repo/flathub.flatpakrepo'}"
    echo
    echo "--- FLATPAK ---"
    flatpak --version
    sudo flatpak remote-add --if-not-exists $remote_name $remote_url
}

# Function to handle Java installation
install_font() {
    echo
    echo "--- FONT ---"
    install_nerd_font "$@"
}

# Function to handle Java installation
install_java() {
    local java_version="$1"
    echo
    echo "--- JAVA ---"
    echo "Installing Microsoft OpenJDK version $java_version..."
    INSTALL_MS_OPENJDK $java_version

    # The first JDK version will be made the active one;
    # multiple are possible for example INSTALL_MS_OPENJDK 21 17 25
    echo
    java -version
}

# Function to handle Homebrew installation
install_homebrew() {
    local shell="${1:-bash}"
    echo
    echo "--- HOMEBREW ---"

    # Install
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "$(brew --version | head -n 1) already installed."
        brew update
    fi

    echo "Setting up environment"
    local BREW_PATH=""
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

    # Persist in shell's .rc file
    if [ -n "$BREW_PATH" ]; then
        echo "Persisting in ~/.${shell}rc"
        eval "$($BREW_PATH shellenv)"
        if ! grep -q "shellenv" "$HOME/.${shell}rc"; then
            (echo; echo "eval \"\$($BREW_PATH shellenv)\"") >> "$HOME/.${shell}rc"
        fi
    fi
}

# Function to install a Homebrew bundle
brew_bundle() {
    local apt_file="$1"
    echo
    echo "--- HOMEBREW $1 ---"
    brew bundle --file="./$1"
}

# Function to display environment information
display_environment() {
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
}

# Function to display current versions
display_versions() {
    echo
    echo "--- CURRENT VERSIONS ---"
    # echo "$(gcloud --version)" # FIXME too verbose: we just want the main gcloud version
    echo "Amazon Web Services: $(aws --version)"
    # echo "Github: $(gh --version)" # FIXME too verbose: just the GH version please
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
