#!/bin/bash
set -e
set -o pipefail

source ./lib/platforms.sh
source ./lib/apt.sh
source ./lib/java.sh
source ./lib/fonts.sh
source ./lib/bootstrap.sh

main() {
    local shell=zsh
    echo "--- ${0} ---"

    install_apt_packages Aptfile
    install_uv $shell
    install_mise $shell
    install_goose
    install_dotnet 10
    configure_shell $shell
    install_nerd_font
    configure_podman
    install_rust
    install_java 21
    install_homebrew $shell
    brew_bundle Brewfile
    display_environment
    display_versions
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
