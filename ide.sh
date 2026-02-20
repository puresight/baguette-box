#!/bin/bash
set -e
OS_TYPE=$(uname -s)

echo
echo "--- IDE ---"
npm install -g jsonc-cli

echo
echo "--- VS CODE ($OS_TYPE) ---"
if ! command -v code &> /dev/null; then
    if [ "$OS_TYPE" == "Linux" ]; then
        sudo apt install -y code
    elif [ "$OS_TYPE" == "Darwin" ]; then
        brew install --cask visual-studio-code
    fi
    echo "Configuring VS Code runtime arguments (argv.json)..."
    mkdir -p ~/.vscode
    ARGV_JSON="$HOME/.vscode/argv.json"
    if [ ! -f "$ARGV_JSON" ]; then
        echo "{}" > "$ARGV_JSON"
    fi
    jsonc set "$ARGV_JSON" "enable-crash-reporter" "false"
    jsonc set "$ARGV_JSON" "password-store" "gnome-libsecret"
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
if [ "$OS_TYPE" == "Linux" ]; then
    VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
elif [ "$OS_TYPE" == "Darwin" ]; then
    VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
fi

if [ -n "$VSCODE_SETTINGS" ]; then
    echo "Configuring VS Code settings at $VSCODE_SETTINGS..."
    mkdir -p "$(dirname "$VSCODE_SETTINGS")"
    if [ ! -f "$VSCODE_SETTINGS" ]; then
        echo "{}" > "$VSCODE_SETTINGS"
    fi
    jsonc set "$VSCODE_SETTINGS" '"editor.formatOnSave"' true
    jsonc set "$VSCODE_SETTINGS" '"editor.inlineSuggest.enabled"' true
else
    echo "Unsupported OS for automated VS Code settings configuration."
fi

echo
echo "Ready."
