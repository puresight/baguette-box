#!/bin/bash
set -e
set -o pipefail

# TODO: update this function with additional functionality in the index.sh version
function install_eget {
    if ! command -v eget &> /dev/null; then
        echo "Installing eget..."
        curl https://zyedidia.github.io/eget.sh | sh
        mkdir -p "$HOME/.local/bin"
        mv eget "$HOME/.local/bin/"
    fi
    eget --version || { echo "❌ Error: eget install failed" >&2; exit 1; }
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then install_eget "$@"; fi
