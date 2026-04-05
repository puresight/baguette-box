#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to install a Homebrew bundle
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_homebrew_packages() {
    local brewfile="${1:-homebrew/${OS_FAMILY}.Brewfile}"
    brew bundle --file="$SCRIPTROOT/$brewfile"
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_homebrew_packages "$@"
fi
