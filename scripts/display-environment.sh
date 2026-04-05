#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to display environment information
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

display_environment() {
    if [ "$OS_FAMILY" == "macos" ]; then
        sw_vers
    elif command -v hostnamectl &> /dev/null; then
        hostnamectl
    else
        cat /etc/os-release
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    display_environment "$@"
fi
