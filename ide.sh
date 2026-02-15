#!/bin/bash
set -e

OS_TYPE=$(uname -s)

echo "--- 1. INSTALLING VS CODE ($OS_TYPE) ---"
if ! command -v code &> /dev/null; then
    if [ "$OS_TYPE" == "Linux" ]; then
        sudo apt update && sudo apt install -y wget gpg
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        rm -f packages.microsoft.gpg
        sudo apt update && sudo apt install -y code
    elif [ "$OS_TYPE" == "Darwin" ]; then
        brew install --cask visual-studio-code
    fi
else
    echo "VS Code already installed."
fi

echo "--- 2. INSTALLING VERIFIED EXTENSIONS ---"
# Only installing extensions from verified publishers (Microsoft, Google, etc.)
code --install-extension github.copilot
code --install-extension ms-python.python
code --install-extension golang.go
code --install-extension rust-lang.rust-analyzer
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode

echo "--- IDE SETUP COMPLETE ---"
