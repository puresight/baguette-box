#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# Dependencies:
#   - PLATFORM global variable
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# --- load library code ---
. "$SCRIPTROOT/scripts/lib/platforms.sh" || { echo "❌ Error: scripts/platforms.sh not found."; exit 1; }
. "$SCRIPTROOT/scripts/lib/apt.sh"     # Debian APT fiunction(s)
. "$SCRIPTROOT/scripts/lib/flatpak.sh" # Flatpak install fiunction(s)
. "$SCRIPTROOT/scripts/lib/fonts.sh"   # Nerd Font installation fiunction(s)
. "$SCRIPTROOT/scripts/lib/rust.sh"    # Rust install fiunction(s)
. "$SCRIPTROOT/scripts/lib/java.sh"    # OpenJDK install fiunction(s)
. "$SCRIPTROOT/scripts/lib/mc.sh"      # Minio Client install fiunction(s)
. "$SCRIPTROOT/scripts/lib/json.sh"    # for VS Code configuring fiunction(s)

# Function to display help information
print_help() {
    cat << EOF
Usage: ${0} [OPTIONS]

Options:
  -h, --help      Show this help message and exit
  -i, --install   Install all VS Code components (default)
  -c, --config    Specify configuration file (required)
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

# Function to configure APT
configure_apt() {
    sudo apt update -qq
    sudo apt autoremove -y
    sudo apt autoclean -y
    _add_apt_sources
}

# Function to handle APT package installation
#   dependencies: configure_apt
install_apt_packages() {
    local apt_file="${1:-apt/apt.dep}"

    echo "Installing packages from $apt_file..."
    if [ -f "$apt_file" ]; then
        sudo DEBIAN_FRONTEND=noninteractive apt install -y $(cat "$apt_file" | sed 's/#.*$//' | sed '/^[[:space:]]*$/d' | tr '\n' ' ')
    else
        echo "❌ Error: file '$apt_file' not found" >&2
        exit 1
    fi
}

# Function
#   docs: https://github.com/zyedidia/eget?tab=readme-ov-file#readme
#   dependencies: (none)
install_eget() {
    if ! command -v eget &> /dev/null; then
        mkdir -p "$BIN_DIR"
        (cd "$BIN_DIR" && curl -sSL https://zyedidia.github.io/eget.sh | sh)
    fi
    eget --version
    local zshenv="$HOME/.zshenv"
    if [ ! -f "$zshenv" ] || ! grep -q "EGET_BIN=" "$zshenv"; then
        echo 'export EGET_BIN="$HOME/.local/bin"' >> "$zshenv"
    fi
}

# Function to handle UV installation
#   dependencies: (none)
install_uv() {
    local shell="${1:-zsh}"

    if ! command -v uv &>/dev/null; then
        echo "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        export PATH="$HOME/.cargo/bin:$PATH"
        grep -qF 'export UV_NO_BUILD=1' ~/.${shell}rc || echo 'export UV_NO_BUILD=1' >> ~/.${shell}rc
    else
        uv self update
    fi
    uv --version
    uv python install
}

# Function to install using UV (e.g. Ansible)
#   dependencies: install_uv
install_using_uv_with_executables_from() {
    local pkg_name="${1:-ansible}"
    local with_executables_from="${2:-ansible-core,ansible-lint}"
    local test_arg="${3:-localhost -m ping}"

# uv tool install --with-executables-from ansible-core,ansible-lint ansible
    if ! uv tool install --with-executables-from "$with_executables_from" "$pkg_name"; then
        echo "❌ Error: failed: 'uv tool install --with-executables-from $with_executables_from $pkg_name'"
        return 1
    fi

    # Integrity Verification
    # While uv verifies on download, we can manually check the binary path
    local pkg_path=$(which "$pkg_name" 2>/dev/null)
    if [[ -z "$pkg_path" ]]; then
        echo "❌ Error: $pkg_name binary not found in PATH."
        return 1
    fi
    "$pkg_name" --version | head -n 1
    echo "$pkg_path"

    # Functional Test
    echo "Ran test: '$pkg_name $test_arg'"
    if ! $pkg_name $test_arg > /dev/null 2>&1; then
        echo "❌ Error: functional test failed." >&2
        return 1
    fi
}

# Function to handle MISE installation per https://mise.jdx.dev/installing-mise.html
#   dependencies: (none)
install_mise() {
    local shell="${1:-zsh}"

    export PATH="$HOME/.local/bin:$PATH"
    if ! command -v mise &>/dev/null; then
        # Install mise and add activation to ~/.zshrc
        echo "Installing mise..."
        curl https://mise.run/$shell | sh
    else
        # mise v
        mise self-update -y
    fi
    mise --version
}

# Function to install mise tools
#   dependencies: install_mise
install_mise_tools() {
    local marker_file="$HOME/.cache/baguette-box/.mise-installed"
    if [ ! -f "$marker_file" ]; then
        mise trust -y
        mise install
        mkdir -p "$(dirname "$marker_file")"
        touch "$marker_file"
    else
        echo "The mise.toml tools were installed on $(date -r "$marker_file" '+%A %B %-d %Y' | awk '{d=$3;s="th";if(d%10==1&&d!=11)s="st";if(d%10==2&&d!=12)s="nd";if(d%10==3&&d!=13)s="rd";printf "%s, %s %d%s, %s",$1,$2,d,s,$4}')."
    fi

    # Activate mise environment for the current shell
    eval "$(mise hook-env)"
}

# Function to install and configure fzf and zoxide terminal tools
#   dependencies: configure_shell
install_terminal_tools() {
    local shell="${1:-zsh}"
    local rc_file="$HOME/.${shell}rc"

    echo "${FUNCNAME[0]}"

    # --- Install fzf ---
    # We use git clone and the official install script because it's the most
    # reliable way to set up shell integration (key bindings, completion).
    if [ ! -d "$HOME/.fzf" ]; then
        echo "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        # The --all flag installs for bash, zsh, and fish non-interactively.
        # It adds the necessary source line to the shell's rc file.
        "$HOME/.fzf/install" --all
    else
        echo "fzf appears to be installed (found ~/.fzf)."
    fi
    export PATH="$PATH:$HOME/.fzf/bin"
    echo "fzf $(fzf --version)"

    # --- Install zoxide ---
    if ! command -v zoxide &> /dev/null; then
        echo "Installing zoxide..."
        local zoxide="ajeetdsouza/zoxide"
        if ! eget $zoxide --to "$BIN_DIR/zoxide"; then
            echo "❌ Error: Failed to install zoxide using eget." >&2
            return 1
        fi
        echo "zoxide installed successfully to $BIN_DIR/zoxide."
    else
        echo "zoxide is already installed."
    fi
    zoxide --version

    # --- Configure zoxide ---
    # This adds the necessary hook to the shell's rc file to make zoxide work.
    # The hook enables 'z' to work and integrates with fzf automatically if found.
    if ! grep -q "zoxide init" "$rc_file"; then
        echo "Configuring zoxide for $shell..."
        echo '' >> "$rc_file"
        echo '# Initialize zoxide for smart directory changing' >> "$rc_file"
        echo 'eval "$(zoxide init '"$shell"')"' >> "$rc_file"
        echo "zoxide configured in $rc_file."
    fi
}

# Function to install Ruby on Rails
#   dependencies: install_mise_tools (for Ruby)
install_rails() {
    if ! gem list -i "^rails$" > /dev/null; then
        echo "Installing Rails..."
        gem install rails
    fi
    echo "$(rails --version) is installed"
}

# Function to install Jekyll
#   dependencies: install_mise_tools (for Ruby)
install_jekyll() {
    if ! gem list -i "^jekyll$" > /dev/null; then
        echo "Installing Jekyll..."
        gem install jekyll bundler
        gem install logger
        # Regenerate shims so 'jekyll' and 'bundle' commands work
        mise reshim
    fi
    echo "bundle $(bundle --version) is installed"
    echo "$(jekyll --version)"
}

# Function to handle GOOSE installation
#   dependencies: (none)
install_goose() {
    if ! command -v goose --version &> /dev/null; then
        curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | CONFIGURE=false bash
    fi
    echo "goose version$(goose --version)"
}

# Function to handle .NET installation
#   dependencies: configure_apt
install_dotnet() {
    for arg in "$@"; do
        if [ "$arg" != "$PLATFORM" ]; then
            echo "Installing .NET SDK $arg..."
            sudo DEBIAN_FRONTEND=noninteractive apt install -y "dotnet-sdk-$arg.0"
        fi
    done
    sudo DEBIAN_FRONTEND=noninteractive apt install -y powershell
    dotnet --version
    pwsh --version
}

# FIXME refactor so no longer requires on install_dotnet to run
# Function to handle shell configuration
#   dependencies: install_dotnet
configure_shell() {
    local shell="${1:-zsh}"
    local rc_file="$HOME/.${shell}rc"

    if [ "$PLATFORM" == "debian" ]; then
        local target_shell
        target_shell=$(which "$shell")
        if [ "$SHELL" != "$target_shell" ]; then
            echo "Changing user shell to $target_shell"
            sudo chsh -s "$target_shell" "$USER"
        fi

        # Add ~/.local/bin to path in rc_file
        if ! grep -q "PATH=" "$rc_file"; then
            echo "# Include bin dir in path; Move this to top!" >> "$rc_file"
            echo 'eval "export PATH=~/.local/bin:$PATH"' >> "$rc_file"
        fi

        # Posh exists? upgrade it! No posh, install it.
        if command -v oh-my-posh &> /dev/null; then
            oh-my-posh upgrade
        else
            curl -s https://ohmyposh.dev/install.sh | bash -s
        fi

        # Posh's config persists in shell's .rc file
        if ! grep -q "oh-my-posh init $shell" "$rc_file"; then
            echo "# Integrate Posh" >> "$rc_file"
            echo 'eval "$(oh-my-posh init '"$shell"' --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/pure.omp.json)"' \
                >> "$rc_file"
            echo "Persisting in $rc_file"
        fi

        # Configure Posh for Powershell
        echo "pwsh $(pwsh --version)" 
        pwsh -NoProfile -File ./powershell.ps1

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
#   dependencies: install_apt_packages
configure_podman() {
    podman --version
    # The Problem: By default, a Linux user only has one UID (yours). To run a container, Podman needs to pretend to be "root" inside the container while remaining a "normal user" outside. It does this by mapping a range of UIDs from the host to the container.
    # The Fix: By adding $USER:100000:65536 to /etc/subuid and subgid, you are granting your user permission to "own" 65,536 subordinate IDs.
    local sub_entry="${USER}:100000:65536"
    local changes_made=false

    if ! grep -q "^${sub_entry}$" /etc/subuid &>/dev/null; then
        echo "Defining subordinate user IDs for ${USER} in /etc/subuid..."
        echo "${sub_entry}" | sudo tee -a /etc/subuid >/dev/null
        changes_made=true
    fi

    if ! grep -q "^${sub_entry}$" /etc/subgid &>/dev/null; then
        echo "Defining subordinate group IDs for ${USER} in /etc/subgid..."
        echo "${sub_entry}" | sudo tee -a /etc/subgid >/dev/null
        changes_made=true
    fi

    if [ "$changes_made" = true ]; then
        echo "See https://github.com/containers/podman/blob/main/troubleshooting.md"
        echo "Applying any changes to the current session"
    fi
    # Migrate existing containers to a new version of Podman and refresh the runtime to recognize these new mappings. This prevents the common ERRO[0000] user namespaces are not enabled error.
    podman system migrate
}

# Function to handle Rust installation with cargo-binstall
#   dependencies: configure_apt, install_apt_packages
install_rust() {
    _install_rust
}

# Function to install storage-related command-line tools
#   dependencies: configure_shell
install_storage_tools() {
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

# Function
#   dependencies: configure_apt, configure_shell
configure_flatpak() {
    echo "sorry: flatpak is disabled for troubleshooting."
    return
    _configure_flatpak "$@"
}

# Function
#   dependencies: (none)
install_font() {
    install_nerd_font "$@"
}

# Function
#   dependencies: configure_apt
install_java() {
    local java_version="$1"
    echo "Installing Microsoft OpenJDK version $java_version..."
    install_ms_openjdk $java_version

    # The first JDK version will be made the active one;
    # multiple are possible for example install_ms_openjdk 21 17 25
    echo
    java -version
}

# Function
#   dependencies: configure_shell
install_homebrew() {
    local shell="${1:-zsh}"
    local rc_file="$HOME/.${shell}rc"

    # Install
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        brew update
    fi

    echo "Setting up environment"
    local BREW_PATH=""
    if [ "$PLATFORM" == "debian" ]; then
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
        echo "installed: $BREW_PATH"
        echo "Persisting in $rc_file"
        eval "$($BREW_PATH shellenv)"
        if ! grep -q "shellenv" "$rc_file"; then
            (echo; echo "eval \"\$($BREW_PATH shellenv)\"") >> "$rc_file"
        fi
        brew --version
    fi
}

# Function to install a Homebrew bundle
#   dependencies: install_homebrew
install_homebrew_packages() {
    local apt_file="${1:-homebrew/homebrew.dep}"
    brew bundle --file="./$1"
}

# Function to install VS Code and/or update its argv.json
#   dependencies: configure_apt, install_apt_packages, install_mise (for Node)
install_code() {
    local repo_path="$(cd -- "$(dirname -- "${BASH_SOURCE:-$0}")" && cd .. && pwd)"
    local argv_file="${1:-code/argv.json}"

    local vscode_argv="$repo_path/$argv_file"

    if ! command -v code &> /dev/null; then
        echo "Installing VS Code..."
        if [ "$PLATFORM" == "debian" ]; then
            _install_vscode_debian
        elif [ "$PLATFORM" == "macos" ]; then
            brew install --cask visual-studio-code
        else
            echo "Unsupported platform $PLATFORM"
        fi

        echo "Configuring VS Code runtime arguments"
        if [ -n "$argv_json" ]; then
            mkdir -p ~/.vscode
            local argv_json="$HOME/.vscode/argv.json"
            update_json $vscode_argv $argv_json
            if [ $? -ne 0 ]; then
                echo "❌ Error: Update failed!" >&2
                return 1
            fi
            echo "✓ Updated"
        fi
    else
        echo "VS Code is already installed. Checking for updates..."
        if [ "$PLATFORM" == "debian" ]; then
            sudo DEBIAN_FRONTEND=noninteractive apt install -y code
            sudo rm -f /etc/apt/sources.list.d/vscode.list
        elif [ "$PLATFORM" == "macos" ]; then
            brew upgrade --cask visual-studio-code
        fi
        echo "VS Code: $(code --version)"
    fi
}

# Function to install VS Code extensions
#   dependencies: install_code
install_code_extensions() {
    local ext_file="${1:-code/code.dep}"

    if [ -f $ext_file ]; then
        while IFS= read -r extension || [ -n "$extension" ]; do
            # Ignore comments and empty lines
            [[ "$extension" =~ ^#.*$ ]] && continue
            [[ -z "$extension" ]] && continue
            echo "+extension: $extension"
            code --install-extension "$extension"
        done < "$ext_file"
    else
        echo "❌ Error: $ext_file file not found! skipping it." >&2
    fi
}

# Function to configure VS Code settings
#   dependencies: install_code, install_apt_packages, install_mise (for Node)
configure_code() {
    local repo_path="$(cd -- "$(dirname -- "${BASH_SOURCE:-$0}")" && cd .. && pwd)"
    local settings_file="${1:-code/user-settings.json}"

    local vscode_user_settings="$repo_path/$settings_file"

    if [ "$PLATFORM" == "debian" ]; then
        target_json="$HOME/.config/Code/User/settings.json"
    elif [ "$PLATFORM" == "macos" ]; then
        target_json="$HOME/scriptsrary/Application Support/Code/User/settings.json"
    fi
    if [ -n "$target_json" ]; then
        mkdir -p "$(dirname "$target_json")"
        update_json $vscode_user_settings $target_json
        if [ $? -ne 0 ]; then
            echo "❌ Error: settings update failed." >&2
            exit 1
        fi
        echo "done"
    else
        echo "❌ Error: platform unsupported" >&2
        # exit 1
    fi
}

# Function to display environment information
#   dependencies: (none)
display_environment() {
    if [ "$PLATFORM" == "debian" ]; then
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
#   dependencies: (none)
display_versions() {
    # if command -v gcloud &> /dev/null; then echo "$(gcloud --version)"; fi # FIXME too verbose: we just want the main gcloud version
    if command -v aws &>/dev/null; then echo "Amazon Web Services: $(aws --version)"; fi
    # if command -v gh &> /dev/null; then echo "Github: $(gh --version)"; fi # FIXME too verbose: just the GH version please
    if command -v uv &>/dev/null; then echo "$(uv --version)"; fi
    if command -v python3 &>/dev/null; then echo "$(python3 --version)"; fi
    if command -v rustc &>/dev/null; then echo "$(rustc --version)"; fi
    if command -v cargo &>/dev/null; then echo "$(cargo --version)"; fi
    if command -v go &>/dev/null; then echo "$(go version)"; fi
    if command -v ruby &>/dev/null; then echo "$(ruby --version)"; fi
    if command -v javac &>/dev/null; then echo "$(javac -version 2>&1)"; fi
    if command -v dotnet &>/dev/null; then echo "dotnet $(dotnet --version)"; fi
    if command -v pwsh &>/dev/null; then echo "pwsh $(pwsh --version)"; fi
    if command -v node &>/dev/null; then echo "Node $(node -v)"; fi
    if command -v npm &>/dev/null; then echo "npm $(npm -v)"; fi
}

# Function
#   dependencies: (none)
show_message() {
    echo "${1}" > /dev/null
}
