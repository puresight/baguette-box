#!/bin/bash
set -e
set -o pipefail

source ./lib/platforms.sh   # PLATFORM variable
source ./lib/json.sh
source ./lib/ide.sh

# Global variable
MODE="install"

main() {
    echo "--- ${0} ---"
    install_vscode vscode-updates/argv.json
    install_extensions vscodeExtensions
    configure_vscode vscode-updates/user-settings.json
}

MODE="install"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            print_help
            exit 0
            ;;
        -i|--install)
            echo "Install mode" # default
            shift
            ;;
        -u|--update)
            echo "Update mode is not implemented yet"
            echo
            print_help
            exit 1
            ;;
        -g|--upgrade)
            echo "Upgrade mode is not implemented"
            echo
            print_help
            exit 1
            ;;
        *)
            echo "Unknown option: $1"
            echo
            print_help
            exit 1
            ;;
    esac
done

main "$@"
