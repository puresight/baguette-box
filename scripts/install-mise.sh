#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to handle MISE installation
#   See: https://mise.jdx.dev/installing-mise.html
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_mise() {
    # Detect the current shell from its name for the installer script.
    local shell_name=$(basename "$SHELL")

    export PATH="$HOME/.local/bin:$PATH"
    if ! command -v mise &>/dev/null; then
        # Install mise and add activation to ~/.zshrc
        echo "Installing mise..."
        curl https://mise.run/"$shell_name" | sh
    else
        # mise v
        mise self-update -y
    fi
    eval "$(mise hook-env)" # Activate mise environment for the current shell
    mise --version
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_mise "$@"
fi
