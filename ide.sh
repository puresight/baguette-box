#!/bin/bash
set -e
set -o pipefail

source ./lib/platforms.sh
source ./lib/json.sh
source ./lib/ide.sh

main() {
    echo "--- ${0} ---"
    install_vscode vscode-updates/argv.json
    install_extensions vscodeExtensions
    configure_vscode vscode-updates/user-settings.json
}

main "$@"
