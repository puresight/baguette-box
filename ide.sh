#!/bin/bash
set -e
set -o pipefail

echo "--- IDE ---"

source ./lib/platforms.sh
source ./lib/json.sh
source ./lib/ide.sh

install_vscode vscode-updates/argv.json
install_extensions vscodeExtensions
configure_vscode vscode-updates/user-settings.json

echo
echo "Ready."
