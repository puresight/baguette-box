#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#       Function to check RPM or RPM-OSTREE availability
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

_check_rpm() {
    # dnf/yum/rpm lock the database files in /var/lib/rpm during transactions.
    # We can use lsof to see if any process is holding a lock on them.
    if lsof /var/lib/rpm/__db.* >/dev/null 2>&1; then
        echo "❌ Error: The RPM database is locked by another process (e.g., dnf)." >&2
        return 1
    fi
    echo "✓ RPM/DNF is available."
}

_check_rpm_ostree() {
    # rpm-ostree blocks other transactions, so running a read-only command
    # is a good way to check if it's busy.
    if ! rpm-ostree status >/dev/null 2>&1; then
        echo "❌ Error: rpm-ostree is currently locked by another process." >&2
        return 1
    fi
    echo "✓ rpm-ostree is available."
}

check_rpm() {
    if command -v rpm-ostree &> /dev/null; then
        _check_rpm_ostree
    elif command -v dnf &> /dev/null || command -v rpm &> /dev/null; then
        _check_rpm
    else
        echo "❌ Error: No RPM package manager (rpm-ostree, dnf) found on this $OS_FAMILY system." >&2
        return 1
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    check_rpm "$@"
fi
