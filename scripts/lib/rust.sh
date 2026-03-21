#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function ------------------------------------------------------------
# TODO investigate re-enabling rustup update; it compiled from source 157 packages (too much) last time
# Install Rust language compiler, package management, LSP, etc.
_install_rust() {
    if command -v rustup &> /dev/null; then
        echo "Run 'rustup update' soon."
        # rustup update             # disabled because it takes too long / several minutes.
        # cargo install-update -a   #
    else
        # Rust APT dependencies: build-essential curl
        # We download and run the rustup-init script non-interactively, using options:
        #   -sSf: Silent, show errors, fail on server errors
        #   -y: Auto-confirm default installation options
        echo "Installing Rust"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        . "$HOME/.cargo/env"
        echo "Adding cargo-binstall"
        curl -L https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
        cargo binstall cargo-update --no-confirm
    fi
    echo "$(rustc --version"
    echo "$(cargo --version"
    echo "cargo-binstall $(cargo binstall -V $non_interactive)"
    echo "Installing Just LSP language server for editor support..."
    local non_interactive="--no-confirm --disable-telemetry"
    cargo binstall $non_interactive just-lsp
}
