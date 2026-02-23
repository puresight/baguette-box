#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   This shell script installs APT sources for Microsoft package repos
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

MS_GPG_URL="https://packages.microsoft.com/keys/microsoft.asc"
MS_KEYRING="/usr/share/keyrings/microsoft.gpg"

# Download and dearmor the GPG key
sudo mkdir -p /usr/share/keyrings
if [ ! -f "$MS_KEYRING" ]; then
    curl -sSL "$MS_GPG_URL" | sudo gpg --dearmor -o "$MS_KEYRING"
fi

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# Install the APT repository sources
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

source /etc/os-release

# Define repositories as a list of strings: "REPO_URL REPO_LIST_FILE RELEASE_SUITE"
REPOS=(
    "https://packages.microsoft.com/$ID/$VERSION_ID/prod /etc/apt/sources.list.d/microsoft-prod.list $VERSION_CODENAME"
    "https://packages.microsoft.com/repos/code /etc/apt/sources.list.d/vscode.list stable"
)

# Loop through the array and add each repository
for repo_info in "${REPOS[@]}"; do
    # Parse the string into variables
    read -r REPO_URL REPO_LIST SUITE <<< "$repo_info"

    # Create the source list using the 'signed-by' attribute
    if [ ! -f "$REPO_LIST" ]; then
        echo "deb [arch=amd64,arm64,armhf signed-by=$MS_KEYRING] $REPO_URL $SUITE main" | \
        sudo tee "$REPO_LIST" > /dev/null
    fi
done

# Update package lists to include the new repositories
sudo apt update -qq

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------