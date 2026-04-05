#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#       Function to install APT packages.
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

install_apt_packages() {
    local apt_file="${1:-apt/apt.Packages}"

    echo "Installing packages from $apt_file..."
    if [ -f "$apt_file" ]; then
        sudo DEBIAN_FRONTEND=noninteractive apt install -y $(cat "$apt_file" | sed 's/#.*$//' | sed '/^[[:space:]]*$/d' | tr '\n' ' ')
    else
        echo "❌ Error: file '$apt_file' not found" >&2
        exit 1
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_apt_packages
fi
