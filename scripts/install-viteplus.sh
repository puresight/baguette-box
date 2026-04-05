#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Install VitePlus and Node
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_viteplus() {
    local node_version="${1:-22}"

    if ! command -v vp &> /dev/null; then
        echo "Installing VitePlus..."
        curl -sL https://vite-plus.com/install.sh | bash -s -- --node-version "$node_version"
        export PATH="$HOME/.vite-plus/bin:$PATH" # Activate vp for the current shell session
        eval "$(vp env)"
        echo "viteplus version $(vp --version)"
        echo "node version $(node -v)"
    else
        echo "VitePlus is already installed."
        echo "✓ Vite+ is installed, run `vp env doctor` to troubleshoot/configure."
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_viteplus "$@"
fi
