#!/bin/bash
set -e
set -o pipefail

echo "--- IDE ---"

source ./lib/platforms.sh
source ./lib/json.sh
source ./lib/ide.sh

install_vscode   "$PLATFORM" vscode-updates/argv.json
install_extensions
configure_vscode "$PLATFORM" vscode-updates/user-settings.json

echo
echo "Ready."
