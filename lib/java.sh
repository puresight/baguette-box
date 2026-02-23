#!/bin/bash

# Function ------------------------------------------------------------
INSTALL_MS_OPENJDK() {
    # Arguments are JDK versions to install
    # The first argument is the JDK to make active

    if [[ $# -eq 0 ]]; then
        echo "Error: No version numbers provided. Usage: install_ms_openjdk <default_version> [additional_versions...]" >&2
        return 1
    fi

    local DEFAULT_VER=$1
    local ARCH
    ARCH=$(dpkg --print-architecture)

    for ver in "$@"; do
        sudo apt-get install -y "msopenjdk-$ver"
    done
    sudo apt autoremove -y

    # Configure the system default
    local JAVA_PATH="/usr/lib/jvm/msopenjdk-$DEFAULT_VER-$ARCH/bin/java"
    local JAVAC_PATH="/usr/lib/jvm/msopenjdk-$DEFAULT_VER-$ARCH/bin/javac"

    if [[ -x "$JAVA_PATH" ]]; then
        # Use sudo to update the system-wide alternatives
        sudo update-alternatives --set java "$JAVA_PATH" > /dev/null 2>&1
        sudo update-alternatives --set javac "$JAVAC_PATH" > /dev/null 2>&1
    else
        echo "Error: Could not set $DEFAULT_VER as default. Binary not found at $JAVA_PATH." >&2
        return 1
    fi
}
