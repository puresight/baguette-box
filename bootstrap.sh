#!/bin/bash
set -e
set -o pipefail

SCRIPTROOT=$(dirname "${BASH_SOURCE[0]}") # Global var
source "$SCRIPTROOT/lib/bootstrap.sh"

main() {
    local shell=zsh
    echo "--- ${0} ---"
    install_apt_packages Aptfile
    install_storage_tools
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

# Determine mode of operation; the default is help.
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--install)
            MODE="install"; echo "Install mode"; shift;;
        -h|--help)
            print_help; exit 0;;
        -u|--update)
            MODE="update";  echo "Update is not implemented"; echo; print_help; exit 1;;
        -g|--upgrade)
            MODE="upgrade"; echo "Upgrade is not implemented"; echo; print_help; exit 1;;
        -n|--dry-run|--noop|--whatif)
            MODE="dry-run"; echo "Dry run is not implemented"; echo; print_help; exit 1;;
        *)
            echo "Unknown option: $1"; echo; print_help; exit 1;;
    esac
done

if [ "$MODE" = "install" ]; then
    main "$@"
else
    print_help
fi
