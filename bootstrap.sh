#!/bin/bash
set -e

source ./lib/platforms.sh
source ./lib/apt.sh
source ./lib/java.sh
source ./lib/fonts.sh
source ./lib/bootstrap.sh

# Main execution
main() {
    local shell=zsh
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
main "$@"
