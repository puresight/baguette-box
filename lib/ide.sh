#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# Dependencies:
#   - PLATFORM global variable
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function to install VS Code
install_vscode() {
    local repo_path="$(cd -- "$(dirname -- "${BASH_SOURCE:-$0}")" && cd .. && pwd)"
    local vscode_argv="$repo_path/$1"

    echo
    echo "--- VS CODE ($PLATFORM) ---"
    if ! command -v code &> /dev/null; then
        if [ "$PLATFORM" == "linux" ]; then
            sudo apt install -y code
        elif [ "$PLATFORM" == "macos" ]; then
            brew install --cask visual-studio-code
        else
            echo "Unsupported platform $PLATFORM"
        fi

        echo "Configuring VS Code runtime arguments (argv.json)..."
        if [ -n "$argv_json" ]; then
            mkdir -p ~/.vscode
            local argv_json="$HOME/.vscode/argv.json"
            UPDATE_JSON $vscode_argv $argv_json
            if [ $? -ne 0 ]; then
                echo "Error: Update failed!" >&2
                return 1
            fi
        fi
    else
        echo "VS Code: $(code --version)"
    fi
}

# Function to install VS Code extensions
install_extensions() {
    local ext_file="$1"
    echo
    echo "--- EXTENSIONS ---"
    if [ -f $ext_file ]; then
        while IFS= read -r extension || [ -n "$extension" ]; do
            # Ignore comments and empty lines
            [[ "$extension" =~ ^#.*$ ]] && continue
            [[ -z "$extension" ]] && continue
            echo "Installing extension: $extension"
            code --install-extension "$extension"
        done < "$ext_file"
    else
        echo "Error: $ext_file file not found! skipping extension installation." >&2
    fi
}

# Function to configure VS Code settings
configure_vscode() {
    local repo_path="$(cd -- "$(dirname -- "${BASH_SOURCE:-$0}")" && cd .. && pwd)"
    local vscode_user_settings="$repo_path/$1"

    echo
    echo "--- CONFIGURATION ---"
    if [ "$PLATFORM" == "linux" ]; then
        TARGET_JSON="$HOME/.config/Code/User/settings.json"
    elif [ "$PLATFORM" == "macos" ]; then
        TARGET_JSON="$HOME/Library/Application Support/Code/User/settings.json"
    fi
    if [ -n "$TARGET_JSON" ]; then
        mkdir -p "$(dirname "$TARGET_JSON")"
        UPDATE_JSON $vscode_user_settings $TARGET_JSON
        if [ $? -ne 0 ]; then
            echo "Settings update failed."
            exit 1
        fi
    else
        echo "Warning: the VSCode user settings file not found! skipping configuration." >&2
    fi
}
