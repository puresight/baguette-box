#!/bin/bash
set -e
set -o pipefail

OS_TYPE=$(uname -s)
PLATFORM="unknown"
if [ "$OS_TYPE" == "Darwin" ]; then
    PLATFORM="macos"
elif [ "$OS_TYPE" == "Linux" ]; then
    PLATFORM="linux"
fi

function log_unsupported() {
    echo "ERROR: Unsupported platform ($OS_TYPE / $PLATFORM). Only Linux (Crostini/Debian) and MacOS are supported." >&2
    exit 1
}

if [ "$PLATFORM" == "unknown" ]; then
    log_unsupported
fi

SCRIPTDIR=$(cd -- "$(dirname -- "${BASH_SOURCE:-$0}")" && pwd)
VSCODEUSERSETTINGS="vscode-user-settings.json"
VSCODEARGV="vscode-argv.json"

echo
echo "--- IDE START ---"
source ./update_json.sh

echo
echo "--- VS CODE ($OS_TYPE) ---"
if ! command -v code &> /dev/null; then
    if [ "$PLATFORM" == "linux" ]; then
        sudo apt install -y code
    elif [ "$PLATFORM" == "macos" ]; then
        brew install --cask visual-studio-code
    fi
    echo "Configuring VS Code runtime arguments"
    mkdir -p ~/.vscode
    ARGV_JSON="$HOME/.vscode/argv.json"
    if [ -n "$ARGV_JSON" ]; then
        UPDATE_JSON "$SCRIPTDIR/$VSCODEARGV" $ARGV_JSON
        if [ $? -ne 0 ]; then
            echo "Argv update failed."
            exit 1
        fi
    fi
else
    echo "VS Code: $(code --version)"
fi

echo
echo "--- EXTENSIONS ---"
if [ -f "CodeExtensions" ]; then
    while IFS= read -r extension || [ -n "$extension" ]; do
        # Ignore comments and empty lines
        [[ "$extension" =~ ^#.*$ ]] && continue
        [[ -z "$extension" ]] && continue
        echo "Installing extension: $extension"
        code --install-extension "$extension" --force
    done < "CodeExtensions"
else
    echo "Error: CodeExtensions file not found! skipping extension installation."
fi
# code --list-extensions

echo
echo "--- CONFIGURATION ---"
if [ "$PLATFORM" == "linux" ]; then
    TARGET_JSON="$HOME/.config/Code/User/settings.json"
elif [ "$PLATFORM" == "macos" ]; then
    TARGET_JSON="$HOME/Library/Application Support/Code/User/settings.json"
fi
if [ -n "$TARGET_JSON" ]; then
    mkdir -p "$(dirname "$TARGET_JSON")"
    UPDATE_JSON "$SCRIPTDIR/$VSCODEUSERSETTINGS" $TARGET_JSON
    if [ $? -ne 0 ]; then
        echo "Settings update failed."
        exit 1
    fi
else
    echo "Unsupported OS for automated VS Code settings configuration."
    exit 1
fi

echo
echo "Ready."
