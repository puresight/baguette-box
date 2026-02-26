#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#       Install APT sources for any APT package repositories.
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
#   Entry point:
#       This script is self-sufficient and can be run independently.
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function to download and dearmor a GPG key
# Parameters: $1 - GPG key URL, $2 - Keyring filename
install_gpg_key() {
    local gpg_url="$1"
    local keyring_dir="/etc/apt/keyrings"
    local keyring_file="$2"

    sudo mkdir -p $keyring_dir
    keyring_file="$keyring_dir/$keyring_file"
    if [ -f "$keyring_file" ]; then
        echo "$keyring_file exists already."
    else
        echo "Downloading GPG key from $gpg_url"
        curl -sSL "$gpg_url" | sudo gpg --dearmor -o "$keyring_file"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install GPG key"
            return 1
        fi
        echo "Successfully installed GPG key to $keyring_file"
    fi
}

# Function to add an APT repository using DEB822 format
# Parameters: $1 - Sources file path, $2 - Repository URL, $3 - GPG key URL (optional), $4 - Suites (optional), $5 - Components (optional), $6 - Architectures (optional)
add_apt_repository() {
    local sources_file="$1"
    local repo_url="$2"
    local gpg_url="$3"
    local suites="${4:-main}"
    local components="${5:-main}"
    local architectures="${6:-amd64 arm64 armhf}"

    local sources_path="/etc/apt/sources.list.d"

    # Check for required arguments
    if [ -z "$sources_file" ] || [ -z "$repo_url" ]; then
        echo "Error: Missing required arguments. Usage: add_apt_repository <sources_file> <repo_url> [gpg_url] [suites] [components] [architectures]" >&2
        echo 'Help: example invocation...'
        echo '--'
        echo '  add_apt_repository \'
        echo '    example.sources \'
        echo '    https://example.com/repo \'
        echo '    https://example.com/key.gpg \'
        echo '    main \'
        echo '    main \'
        echo '    amd64'
        echo '--'
        return 1
    fi

    # Install GPG key if provided
    if [ -n "$gpg_url" ]; then
        install_gpg_key "$gpg_url" "$(basename "$sources_file" .sources).gpg"
        if [ $? -ne 0 ]; then
            return 1
        fi
    fi

    # Create the source file in DEB822 format
    sources_file="$sources_path/$sources_file"
    if [ -f "$sources_file" ]; then
        echo "$sources_file exists already."
    else

        local sources_content=$(cat << EOF
Types: deb
URIs: $repo_url
Suites: $suites
Components: $components
Architectures: $architectures
Signed-By: $keyring_path
Description: $repo_url
Origin: $(basename "$sources_file" .sources)
EOF
)
        echo
        echo "$sources_content"
        sudo tee "$sources_file" > /dev/null <<< "$sources_content"

        if [ $? -ne 0 ]; then
            echo "Error: Failed to add repository" >&2
            return 1
        fi
        echo "» $sources_file"
        echo
    fi
}

# Function to update package lists
update_package_lists() {
    echo "Updating package lists..."
    sudo apt update -qq
    if ! [ $? -eq 0 ]; then
        echo "Error: Failed to update package lists" >&2
        return 1
    fi
}

# Main script execution
main() {
    echo "--- ${0} ---"

    # Fetch the ID, VERSION_ID, VERSION_CODENAME
    source /etc/os-release

    # Microsoft Linux repository
    add_apt_repository \
        "microsoft-prod.sources" \
        "https://packages.microsoft.com/$ID/$VERSION_ID/prod" \
        "https://packages.microsoft.com/keys/microsoft.asc" \
        "$VERSION_CODENAME" \
        "main"

    # Microsoft VS Code repository
    add_apt_repository \
        "vscode.sources" \
        "https://packages.microsoft.com/repos/code" \
        "https://packages.microsoft.com/keys/microsoft.asc" \
        "stable" \
        "main"

    # Microsoft Azure CLI repository
    add_apt_repository \
        "azure-cli.sources" \
        "https://packages.microsoft.com/repos/azure-cli/" \
        "https://packages.microsoft.com/keys/microsoft.asc" \
        "$(lsb_release -cs)" \
        "main" \
        "$(dpkg --print-architecture)"

    # Google Cloud CLI repository
    add_apt_repository \
        "google-cloud-cli.sources" \
        "https://packages.cloud.google.com/apt" \
        "https://packages.cloud.google.com/apt/doc/apt-key.gpg" \
        "cloud-sdk" \
        "main"

    # Update package lists after adding repositories
    update_package_lists
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
