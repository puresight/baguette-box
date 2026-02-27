#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# Dependencies:
#   - APT source for Microsoft Linux repo must exist
#   - update-alternatives
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function ------------------------------------------------------------
# Arguments are JDK versions to install; the first shall be active.
INSTALL_MS_OPENJDK() {
    # TODO support multi-PLATFORM, like macos
    if [[ $# -eq 0 ]]; then
        echo "Error: No version numbers provided. Usage: install_ms_openjdk <active_version> [additional_versions...]" >&2
        return 1
    fi

    local active_version=$1
    local arch
    arch=$(dpkg --print-architecture)

    for ver in "$@"; do
        sudo apt install -y "msopenjdk-$ver"
    done
    sudo apt autoremove -y

    # Configure the system default
    local java_path="/usr/lib/jvm/msopenjdk-$active_version-$arch/bin/java"
    local javac_path="/usr/lib/jvm/msopenjdk-$active_version-$arch/bin/javac"

    if [[ -x "$java_path" ]]; then
        # Use sudo to update the system-wide alternatives
        sudo update-alternatives --set java "$java_path" > /dev/null 2>&1
        sudo update-alternatives --set javac "$javac_path" > /dev/null 2>&1
    else
        echo "Error: Could not set $active_version as default. Binary not found at $java_path." >&2
        return 1
    fi
}

# Execute INSTALL_MS_OPENJDK function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    INSTALL_MS_OPENJDK "$@"
fi
