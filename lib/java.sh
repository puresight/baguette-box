#!/bin/bash

source /etc/os-release
MS_GPG_URL="https://packages.microsoft.com/keys/microsoft.asc"
MS_KEYRING="/usr/share/keyrings/microsoft-archive-keyring.gpg"
MS_REPO_LIST="/etc/apt/sources.list.d/microsoft-prod.list"

sudo mkdir -p /usr/share/keyrings

# Download and dearmor the GPG key
if [ ! -f "$MS_KEYRING" ]; then
    curl -sSL "$MS_GPG_URL" | sudo gpg --dearmor -o "$MS_KEYRING"
fi

# Create the source list using the 'signed-by' attribute (Debian 12 specific)
# This prevents the GPG NO_PUBKEY errors globally.
if [ ! -f "$MS_REPO_LIST" ]; then
    echo "deb [arch=amd64,arm64,armhf signed-by=$MS_KEYRING] https://packages.microsoft.com/$ID/$VERSION_ID/prod $VERSION_CODENAME main" | \
    sudo tee "$MS_REPO_LIST" > /dev/null
fi

sudo apt update -qq

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
