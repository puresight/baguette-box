#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#       Function to install APT packages.
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_apt_packages() {
    local apt_file="${1:-apt/apt.Packages}"
    local apt_path="$SCRIPTROOT/$apt_file"

    if [ "$OS_FAMILY" != "debian" ]; then
        echo "Skipping APT package installation (non-debian platform)."
        return 0
    fi

    echo "Installing packages from $apt_path..."
    if [ -f "$apt_path" ]; then
        sudo DEBIAN_FRONTEND=noninteractive apt install -y $(cat "$apt_path" | sed 's/#.*$//' | sed '/^[[:space:]]*$/d' | tr '\n' ' ')
    else
        echo "❌ Error: file '$apt_path' not found" >&2
        exit 1
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_apt_packages "$@"
fi
