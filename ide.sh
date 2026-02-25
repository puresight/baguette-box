#!/bin/bash
set -e
set -o pipefail

# Function to install VS Code
install_vscode() {
    local platform="$1"
    local vscode_argv="$2"
    
    echo
    echo "--- VS CODE ($platform) ---"
    if ! command -v code &> /dev/null; then
        if [ "$platform" == "linux" ]; then
            sudo apt install -y code
        elif [ "$platform" == "macos" ]; then
            brew install --cask visual-studio-code
        fi
        echo "Configuring VS Code runtime arguments"
        mkdir -p ~/.vscode
        ARGV_JSON="$HOME/.vscode/argv.json"
        if [ -n "$ARGV_JSON" ]; then
            UPDATE_JSON $vscode_argv $ARGV_JSON
            if [ $? -ne 0 ]; then
                echo "Argv update failed."
                exit 1
            fi
        fi
    else
        echo "VS Code: $(code --version)"
    fi
}

# Function to install VS Code extensions
install_extensions() {
    echo
    echo "--- EXTENSIONS ---"
    if [ -f "vscodeExtensions" ]; then
        while IFS= read -r extension || [ -n "$extension" ]; do
            # Ignore comments and empty lines
            [[ "$extension" =~ ^#.*$ ]] && continue
            [[ -z "$extension" ]] && continue
            echo "Installing extension: $extension"
            code --install-extension "$extension"
        done < "vscodeExtensions"
    else
        echo "Error: vscodeExtensions file not found! skipping extension installation." >&2
    fi
}

# Function to configure VS Code settings
configure_vscode() {
    local platform="$1"
    local vscode_user_settings="$2"

    echo
    echo "--- CONFIGURATION ---"
    if [ "$platform" == "linux" ]; then
        TARGET_JSON="$HOME/.config/Code/User/settings.json"
    elif [ "$platform" == "macos" ]; then
        TARGET_JSON="$HOME/Library/Application Support/Code/User/settings.json"
    fi
    if [ -n "$TARGET_JSON" ]; then
        mkdir -p "$(dirname "$TARGET_JSON")"
        UPDATE_JSON "$script_dir/$vscode_user_settings" $TARGET_JSON
        if [ $? -ne 0 ]; then
            echo "Settings update failed."
            exit 1
        fi
    else
        echo "Warning: the VSCode user settings file not found! skipping configuration." >&2
    fi
}

# Main execution
echo "--- IDE ---"
source ./lib/platforms.sh
source ./lib/json.sh

SCRIPTDIR=$(cd -- "$(dirname -- "${BASH_SOURCE:-$0}")" && pwd)
VSCODEUSERSETTINGS="vscode-updates/user-settings.json"
VSCODEARGV="vscode-updates/argv.json"

install_vscode   "$PLATFORM" "$SCRIPTDIR/$VSCODEARGV"
install_extensions
configure_vscode "$PLATFORM" "$SCRIPTDIR/$VSCODEUSERSETTINGS"

echo
echo "Ready."
