#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to handle .NET and PowerShell installation on Debian
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_microsoft_dotnet() {
    if [ "$OS_FAMILY" != "debian" ]; then
        echo "Skipping .NET APT installation (non-debian platform)."
        return 0
    fi

    for arg in "$@"; do
        if [[ "$arg" =~ ^[0-9]+$ ]]; then
            echo "Installing .NET SDK $arg..."
            sudo DEBIAN_FRONTEND=noninteractive apt install -y "dotnet-sdk-$arg.0"
        fi
    done
    sudo DEBIAN_FRONTEND=noninteractive apt install -y powershell
    dotnet --version
    pwsh --version
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_microsoft_dotnet "$@"
fi
