#!/bin/bash
set -e
set -o pipefail

SCRIPTROOT=$(dirname "${BASH_SOURCE[0]}") # Global
source "$SCRIPTROOT/lib/bootstrap.sh"

main() {
    local shell=zsh
    echo "--- ${0} ---"
    install_apt_packages Aptfile
    install_uv $shell
    install_mise $shell
    install_goose
    install_dotnet 10
    configure_shell $shell
    install_font JetBrainsMono v3.3.0
    configure_podman
    install_rust
    install_java 21
    install_homebrew $shell
    brew_bundle Brewfile
    display_environment
    display_versions
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
