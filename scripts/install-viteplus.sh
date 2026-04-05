#!/bin/bash

. "$SCRIPTROOT/scripts/lib/platforms.sh"

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#   This script installs Vite+ and its ecosystem.
#   See: https://viteplus.dev/
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

install_viteplus() {
    local node_version="${1:-lts}"

    if [ -f "$HOME/.vite-plus/env" ]; then
        . "$HOME/.vite-plus/env"
    fi

    if command -v vp &>/dev/null; then
        # echo "Vite+ is already installed. Upgrading..."
        vp upgrade
        # echo "Upgrading global packages..."
        # vp update -g
    else
        # echo "Installing Vite+ for the first time..."
        # The Vite+ installer script: the -y flag answers yes to its questions
        curl -fsSL https://Vite.Plus | bash -s -- -y
        # echo "Run 'vp help' to explore Vite+"

        # Source the environment to make 'vp' command available in this session
        . "$HOME/.vite-plus/env"
    fi

    # echo "Ensuring Vite+ shims are active..."
    vp env on

    # echo "Setting default Node.js version to '$node_version' and installing..."
    vp env default "$node_version"
    vp env install "$node_version"
}

# Execute the function if the script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_viteplus "$@"
fi
