#!/bin/bash
set -e

OS_TYPE=$(uname -s)

echo
echo "--- IDE SETUP START ---"

echo
echo "--- ADD packages.microsoft.com ---"
if [ "$OS_TYPE" == "Linux" ]; then
    sudo apt update && sudo apt install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update
else
    echo "Skipping APT source on $OS_TYPE"
fi

echo
echo "--- INSTALLING VS CODE ($OS_TYPE) ---"
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
        jaq '.["enable-crash-reporter"] = "false" | .["password-store"] = "gnome-libsecret"' "$ARGV_JSON" > "$tmp" && mv "$tmp" "$ARGV_JSON"
    elif [ "$OS_TYPE" == "Darwin" ]; then
        brew install --cask visual-studio-code
    fi
else
    echo "VS Code: $(code --version)"
fi

echo
echo "--- UPDATE VSCODE EXTENSIONS ---"
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
code --list-extensions

echo
echo "--- CONFIGURE VSCODE & EXTENSIONS ---"
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
    echo "DEBUG jaq start"
    tmp=$(mktemp)
    jaq '.["editor.formatOnSave"] = true |
         .["editor.inlineSuggest.enabled"] = true' "$VSCODE_SETTINGS" > "$tmp" && mv "$tmp" "$VSCODE_SETTINGS"
    # FIXME: Error: failed to parse: string expected
    echo "DEBUG jaq end"
else
    echo "Unsupported OS for automated VS Code settings configuration."
fi

echo
echo "--- IDE SETUP END ---"
