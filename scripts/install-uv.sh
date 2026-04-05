#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to handle UV installation
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_uv() {
    # Detect the current shell from its name to locate the correct rc file.
    local shell_name=$(basename "$SHELL")
    local rc_file="$HOME/.${shell_name}rc"

    if ! command -v uv &>/dev/null; then
        echo "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        export PATH="$HOME/.cargo/bin:$PATH"
        grep -qF 'export UV_NO_BUILD=1' "$rc_file" || echo 'export UV_NO_BUILD=1' >> "$rc_file"
    else
        uv self update
    fi
    uv --version
    # uv python install
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_uv "$@"
fi
