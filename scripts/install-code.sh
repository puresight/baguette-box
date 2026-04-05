#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to install VS Code and/or update its argv.json
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"
. "$SCRIPTROOT/scripts/lib/json.sh"

install_code() {
    local repo_path="$SCRIPTROOT"
    local argv_file="${1:-code/argv.json}"

    local vscode_argv="$repo_path/$argv_file"

    if ! command -v code &> /dev/null; then
        echo "Installing VS Code..."
        if [ "$OS_FAMILY" == "debian" ]; then
            sudo apt update && sudo DEBIAN_FRONTEND=noninteractive apt install -y code
        elif [ "$OS_FAMILY" == "macos" ]; then
            brew install --cask visual-studio-code
        else
            echo "Unsupported platform $OS_FAMILY"
            return 1
        fi

        echo "Configuring VS Code runtime arguments"
        if [ -f "$vscode_argv" ]; then
            mkdir -p ~/.vscode
            local argv_json="$HOME/.vscode/argv.json"
            update_json "$vscode_argv" "$argv_json"
            if [ $? -ne 0 ]; then
                echo "❌ Error: Update failed!" >&2
                return 1
            fi
            echo "✓ Updated"
        fi
    else
        echo "VS Code is already installed. Checking for updates..."
        if [ "$OS_FAMILY" == "debian" ]; then
            sudo DEBIAN_FRONTEND=noninteractive apt install -y code
            sudo rm -f /etc/apt/sources.list.d/vscode.list
        elif [ "$OS_FAMILY" == "macos" ]; then
            brew upgrade --cask visual-studio-code
        fi
        echo "VS Code: $(code --version)"
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_code "$@"
fi
