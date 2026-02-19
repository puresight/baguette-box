#!/bin/bash
set -e

OS_TYPE=$(uname -s)

echo
echo "--- IDE SETUP START ---"

echo
echo "--- ADD APT SOURCE packages.microsoft.com ---"
echo "TODO"
# TODO: add the Microsofft packages APT source which shall be used for several things

echo
echo "--- INSTALLING VS CODE ($OS_TYPE) ---"
if ! command -v code &> /dev/null; then
    if [ "$OS_TYPE" == "Linux" ]; then
        sudo apt update && sudo apt install -y wget gpg
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        rm -f packages.microsoft.gpg
        sudo apt update && sudo apt install -y code

        echo "To fix OS keyring,"
        echo "Destructive overwrite of ~/.vscode/argv.json (runtime arguments)"
        # FIXME: this approach destroys any additions or modifications to argv.json file
        # TODO: use tool jaq (installed during bootstrap) to make the JSON changes
        mkdir -p ~/.vscode
        # Overwrite or create the argv.json to guarantee the password-store is set to gnome-libsecret
        cat << 'JSON_EOF' > ~/.vscode/argv.json
{
    "enable-crash-reporter": "false",
    "password-store": "gnome-libsecret"
}
JSON_EOF
    elif [ "$OS_TYPE" == "Darwin" ]; then
        brew install --cask visual-studio-code
    fi
else
    echo "VS Code: $(code --version)"
fi

echo
echo "--- UPDATE VSCODE EXTENSIONS ---"

# TODO: put list of extensions (to iterate over) in a separate file `CodeExtensions``
code --install-extension ms-python.python --force
code --install-extension golang.go --force
code --install-extension rust-lang.rust-analyzer --force
code --install-extension dbaeumer.vscode-eslint --force
code --install-extension esbenp.prettier-vscode --force
# code --install-extension github.copilot --force
code --install-extension rooveterinaryinc.roo-cline --force
code --list-extensions

echo
echo "--- CONFIGURE VSCODE & EXTENSIONS ---"
echo "TODO"
# TODO: use tool jaq to add configurations for vscode & installed extensions

echo
echo "--- IDE SETUP END ---"
