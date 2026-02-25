#!/bin/bash
set -e

source ./lib/platforms.sh
source ./lib/apt.sh
source ./lib/java.sh
source ./lib/bootstrap.sh

install_apt_packages "$PLATFORM" Aptfile
install_uv           "$PLATFORM"
install_mise         "$PLATFORM" zsh
install_goose        "$PLATFORM"
install_dotnet       "$PLATFORM" 10
configure_shell      "$PLATFORM"
configure_podman     "$PLATFORM"
install_rust         "$PLATFORM"
install_java         "$PLATFORM" 21
install_homebrew     "$PLATFORM"
brew_bundle          "$PLATFORM" Brewfile
display_environment  "$PLATFORM"
display_versions
