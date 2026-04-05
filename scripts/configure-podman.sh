#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to handle Podman configuration
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

configure_podman() {
    if ! command -v podman &> /dev/null; then
        echo "Warning: podman not found. Skipping configuration."
        return 0
    fi

    podman --version
    # The Problem: By default, a Linux user only has one UID (yours). To run a container, Podman needs to pretend to be "root" inside the container while remaining a "normal user" outside. It does this by mapping a range of UIDs from the host to the container.
    # The Fix: By adding $USER:100000:65536 to /etc/subuid and subgid, you are granting your user permission to "own" 65,536 subordinate IDs.
    local sub_entry="${USER}:100000:65536"
    local changes_made=false

    if ! grep -q "^${sub_entry}$" /etc/subuid &>/dev/null; then
        echo "Defining subordinate user IDs for ${USER} in /etc/subuid..."
        echo "${sub_entry}" | sudo tee -a /etc/subuid >/dev/null
        changes_made=true
    fi

    if ! grep -q "^${sub_entry}$" /etc/subgid &>/dev/null; then
        echo "Defining subordinate group IDs for ${USER} in /etc/subgid..."
        echo "${sub_entry}" | sudo tee -a /etc/subgid >/dev/null
        changes_made=true
    fi

    if [ "$changes_made" = true ]; then
        echo "See https://github.com/containers/podman/blob/main/troubleshooting.md"
        echo "Applying any changes to the current session"
    fi
    # Migrate existing containers to a new version of Podman and refresh the runtime to recognize these new mappings. This prevents the common ERRO[0000] user namespaces are not enabled error.
    podman system migrate
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    configure_podman "$@"
fi
