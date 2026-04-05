#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#       Functions to install APT sources for APT package repositories.
#   Supports GPG key management and repository configuration
#   using the newer DEB822 format (.sources).
#
#   Why not just use [software-properties-common](https://packages.debian.org/sid/software-properties-common)?
#   Because that Ubuntu package will hit stable in Debian 14
#   or maybe 13 but in 12 it cannot do DEB822.
#
#   Dependencies:
#       none
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function
_update_package_lists() {
    sudo apt update -qq
    if ! [ $? -eq 0 ]; then
        echo "❌ Error: Failed to update package lists" >&2
        return 1
    fi
    sudo apt autoremove -y
    sudo apt autoclean -y
}

# Function to download & dearmor a GPG key
# Parameters: $1 - GPG key URL, $2 - Keyring filename
_install_gpg_key() {
    local gpg_url="$1"
    local keyring_file="$2"
    # echo "${FUNCNAME[0]}"

    local keyring_dir=$(dirname "$keyring_file")
    sudo mkdir -p -m 755 "$keyring_dir"
    if [ ! -f "$keyring_file" ]; then
        echo "downloading: $gpg_url"
        curl -sSL "$gpg_url" | sudo gpg --dearmor -o "$keyring_file"
        if [ $? -ne 0 ]; then
            echo "❌ Error: Failed to install GPG key" >&2
            return 1
        fi
        echo "installed: $keyring_file"
    fi
}

# Function to add APT sources from gomplate templates
_add_apt_sources() {
    local templates_dir="$SCRIPTROOT/apt"
    local keyring_dir="/etc/apt/keyrings"
    local apt_sources_dest="/etc/apt/sources.list.d"

    # Fetch the ID, VERSION_ID, VERSION_CODENAME from /etc/os-release
    source /etc/os-release
    export ID VERSION_ID VERSION_CODENAME
    export ARCHITECTURES=$(dpkg --print-architecture)

    for template_file in "$templates_dir"/*.sources; do
        if [ -f "$template_file" ]; then
            local sources_name=$(basename "$template_file" .sources)
            local keyring_file="$keyring_dir/$sources_name.gpg"
            
            # Extract Key-URL from the gomplate file
            local key_url=$(grep 'Key-URL:' "$template_file" | sed 's/  Key-URL: //')
            # Install Key
            if [ -n "$key_url" ]; then
                _install_gpg_key "$key_url" "$keyring_file"
            else
                echo "❌ Error: expected Key-URL in $template_file" >&2
            fi

            local sources_file="$apt_sources_dest/$sources_name.sources"
            if [ ! -f "$sources_file" ]; then
                echo "reading: $template_file"
                gomplate -f "$template_file" | grep -v -e '^Data:$' -e '^  Key-URL:' | sudo tee "$sources_file" > /dev/null
                echo "saved: $sources_file"
            else
                echo "exists: $sources_file"
            fi
        fi
    done

    _update_package_lists
}

# Function to configure APT
configure_apt() {
    _update_package_lists
    _add_apt_sources
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    configure_apt
fi
