#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to handle Homebrew installation
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_homebrew() {
    # Detect the current shell from its name to locate the correct rc file.
    local shell_name=$(basename "$SHELL")
    local rc_file="$HOME/.${shell_name}rc"

    if command -v brew &> /dev/null; then
        brew update
    else
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        echo "Setting up environment"
        # Determine Homebrew's installation path programmatically, as 'brew'
        # is not yet in the PATH for a new installation. This avoids a
        # "command not found" error when 'brew --prefix' is called.
        local BREW_PREFIX
        if [[ "$OS_FAMILY" == "macos" ]]; then
            if [[ "$(uname -m)" == "arm64" ]]; then
                BREW_PREFIX="/opt/homebrew"
            else # macos x64
                BREW_PREFIX="/usr/local"
            fi
        else # Linux
            BREW_PREFIX="/home/linuxbrew/.linuxbrew"
        fi
        local BREW_PATH="$BREW_PREFIX/bin/brew"

        # Persist in shell's .rc file
        if [ -f "$BREW_PATH" ]; then # Check if the brew executable actually exists
            echo "installed: $BREW_PATH"
            echo "Persisting in $rc_file"
            eval "$($BREW_PATH shellenv)"
            if ! grep -q "shellenv" "$rc_file"; then
                (echo; echo "eval \"\$($BREW_PATH shellenv)\"") >> "$rc_file"
            fi
            brew --version
        fi
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_homebrew "$@"
fi
