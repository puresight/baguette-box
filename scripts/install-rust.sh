#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#   Uses Rustup to install Rust compiler.
#   See: https://rustup.rs/
#
#   Also installs Just LSP dependency for the Just extension in VS Code.
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function ------------------------------------------------------------
# TODO investigate re-enabling rustup update; it compiled from source 157 packages (too much) last time
# Install Rust language compiler, package management, LSP, etc.
install_rust() {

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

    # Versions
    local non_interactive="--no-confirm --disable-telemetry"
    echo "$(rustc --version)"
    echo "$(cargo --version)"
    echo "cargo-binstall $(cargo binstall -V $non_interactive)"

    # Install LSP dependency of Just editor extension
    if command -v just-lsp &> /dev/null; then
        echo "$(just-lsp -V)"
    else
        echo "Installing Just LSP language server for editor support..."
        cargo binstall $non_interactive just-lsp
    fi
}

# Execute the function if the script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_rust "$@"
fi
