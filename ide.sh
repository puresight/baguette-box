#!/bin/bash
set -e
OS_TYPE=$(uname -s)

echo
echo "--- VS CODE ($OS_TYPE) ---"
if ! command -v code &> /dev/null; then
    if [ "$OS_TYPE" == "Linux" ]; then
        sudo apt install -y code
        echo "Configuring VS Code runtime arguments (argv.json)..."
        mkdir -p ~/.vscode
        ARGV_JSON="$HOME/.vscode/argv.json"
        if [ ! -f "$ARGV_JSON" ]; then
            echo "{}" > "$ARGV_JSON"
        fi
        tmp=$(mktemp)
        echo "Stripping out comments"
        npx strip-json-comments-cli "$ARGV_JSON" | jaq '.["enable-crash-reporter"] = "false" |
            .["password-store"] = "gnome-libsecret"' > "$tmp" && mv "$tmp" "$ARGV_JSON"
        echo "Changes saved"

    elif [ "$OS_TYPE" == "Darwin" ]; then
        brew install --cask visual-studio-code
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
    tmp=$(mktemp)
    echo "Stripping out comments"
    npx strip-json-comments-cli "$VSCODE_SETTINGS" | jaq '.["editor.formatOnSave"] = true |
        .["editor.inlineSuggest.enabled"] = true' > "$tmp" && mv "$tmp" "$VSCODE_SETTINGS"
    echo "Changes saved"
else
    echo "Unsupported OS for automated VS Code settings configuration."
fi

echo
echo "Ready."
