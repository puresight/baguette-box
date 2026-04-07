#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#       Function to check APT status
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

check_apt() {
    if ! command -v apt &> /dev/null; then
        echo "❌ Error: APT command not found." >&2
        return 1
    fi

    # Check for lock files
    if lsof /var/lib/dpkg/lock-frontend >/dev/null 2>&1 || lsof /var/lib/apt/lists/lock >/dev/null 2>&1; then
        echo "❌ Error: APT is currently locked by another process." >&2
        return 1
    fi
    printf "✓ "
    apt --version
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    check_apt "$@"
fi
