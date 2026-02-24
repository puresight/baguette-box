#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# Purpose:
#   This shell script installs APT sources for any package repository
#   Supports GPG key management and repository configuration
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function to download and dearmor a GPG key
# Parameters: $1 - GPG key URL, $2 - Keyring file path
install_gpg_key() {
    local gpg_url="$1"
    local keyring_path="$2"
    
    # Create keyrings directory if it doesn't exist
    sudo mkdir -p "$(dirname "$keyring_path")"
    
    # Download and dearmor the GPG key if it doesn't exist
    if [ ! -f "$keyring_path" ]; then
        echo "Downloading GPG key from $gpg_url..."
        curl -sSL "$gpg_url" | sudo gpg --dearmor -o "$keyring_path"
        if [ $? -eq 0 ]; then
            echo "Successfully installed GPG key to $keyring_path"
        else
            echo "Error: Failed to install GPG key"
            return 1
        fi
    else
        echo "GPG key already exists at $keyring_path"
    fi
}

# Function to add an APT repository
# Parameters: $1 - Repository URL, $2 - List file path, $3 - Suite (optional), $4 - GPG key URL (optional), $5 - Keyring path (optional)
add_apt_repository() {
    local repo_url="$1"
    local list_file="$2"
    local suite="${3:-main}"
    local gpg_url="$4"
    local keyring_path="${5:-/usr/share/keyrings/$(basename "$list_file" .list).gpg}"
    
    # Install GPG key if provided
    if [ -n "$gpg_url" ]; then
        install_gpg_key "$gpg_url" "$keyring_path"
        if [ $? -ne 0 ]; then
            return 1
        fi
    fi
    
    # Create the source list
    if [ ! -f "$list_file" ]; then
        echo "Adding repository: $repo_url"
        
        # Build the deb line with appropriate options
        local deb_line="deb"
        local options=""
        
        # Add GPG keyring if available
        if [ -f "$keyring_path" ]; then
            options="[arch=amd64,arm64,armhf signed-by=$keyring_path]"
        fi
        
        # Create the repository file
        echo "$deb_line $options $repo_url $suite main" | sudo tee "$list_file" > /dev/null
        
        if [ $? -eq 0 ]; then
            echo "Successfully added repository to $list_file"
        else
            echo "Error: Failed to add repository"
            return 1
        fi
    else
        echo "Repository already exists at $list_file"
    fi
}

# Function to update package lists
update_package_lists() {
    echo "Updating package lists..."
    sudo apt update -qq
    if [ $? -eq 0 ]; then
        echo "Package lists updated successfully"
    else
        echo "Error: Failed to update package lists"
        return 1
    fi
}

# Main script execution
main() {
    # Example usage - these can be customized or removed

    # Microsoft Linux repository
    add_apt_repository \
        "https://packages.microsoft.com/$ID/$VERSION_ID/prod" \
        "/etc/apt/sources.list.d/microsoft-prod.list" \
        "$VERSION_CODENAME" \
        "https://packages.microsoft.com/keys/microsoft.asc"

    # Microsoft VS Code repository
    add_apt_repository \
        "https://packages.microsoft.com/repos/code" \
        "/etc/apt/sources.list.d/vscode.list" \
        "stable" \
        "https://packages.microsoft.com/keys/microsoft.asc"

    # Google Cloud repository
    add_apt_repository \
        "https://packages.cloud.google.com/apt" \
        "/etc/apt/sources.list.d/google-cloud-sdk.list" \
        "main" \
        "https://packages.cloud.google.com/apt/doc/apt-key.gpg"
    
    # Update package lists after adding repositories
    update_package_lists
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source /etc/os-release
    main "$@"
fi
