#!/bin/bash
set -e

OS_TYPE=$(uname -s)

echo "--- INSTALLING VS CODE ($OS_TYPE) ---"
if ! command -v code &> /dev/null; then
    if [ "$OS_TYPE" == "Linux" ]; then
        sudo apt update && sudo apt install -y wget gpg
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        rm -f packages.microsoft.gpg
        sudo apt update && sudo apt install -y code

        echo "on ChromeOS, so fixing OS keyring"
        echo "Destructive overwrite of ~/.vscode/argv.json (runtime arguments)"
        # TODO: Make non-destructive; this approach destroys any additions or modifications to argv.json file
        mkdir -p ~/.vscode
        # Overwrite or create the argv.json to guarantee the password-store is set to gnome-libsecret
        cat << 'JSON_EOF' > ~/.vscode/argv.json
{ "password-store": "gnome-libsecret" }
JSON_EOF
    elif [ "$OS_TYPE" == "Darwin" ]; then
        brew install --cask visual-studio-code
    fi
else
    echo "VS Code is already installed"
fi

echo "--- INSTALLING EXTENSIONS ---"
# Only installing extensions from verified publishers (Microsoft, Google, etc.)

code --install-extension ms-python.python --force
code --install-extension golang.go --force
code --install-extension rust-lang.rust-analyzer --force
code --install-extension dbaeumer.vscode-eslint --force
code --install-extension esbenp.prettier-vscode --force
# code --install-extension github.copilot --force
code --install-extension rooveterinaryinc.roo-cline --force

echo "--- IDE SETUP COMPLETE ---"
