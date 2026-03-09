#!/bin/bash

source "$SCRIPTROOT/lib/apt.sh"

# Function
add_apt_sources() {
    echo "${FUNCNAME[0]}"
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
        "$VERSION_CODENAME" \
        "main" \
        "$(dpkg --print-architecture)"

    # Google Cloud CLI repository
    add_apt_repository \
        "google-cloud-cli.sources" \
        "https://packages.cloud.google.com/apt" \
        "https://packages.cloud.google.com/apt/doc/apt-key.gpg" \
        "cloud-sdk" \
        "main"

    # Google Antigravity repository
    add_apt_repository \
        "antigravity.sources" \
        "https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/" \
        "https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg" \
        "antigravity-debian" \
        "main"

    # Github CLI repository
    add_apt_repository \
        "github-cli.sources" \
        "https://cli.github.com/packages" \
        "https://cli.github.com/packages/githubcli-archive-keyring.gpg" \
        "stable" \
        "main" \
        "$(dpkg --print-architecture)"

    update_package_lists
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    add_apt_sources "$@"
fi
