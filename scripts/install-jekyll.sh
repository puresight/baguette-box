#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to install Jekyll
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_jekyll() {
    if [[ "$OS_FAMILY" == "fedora" ]] && ! command -v g++ &>/dev/null; then
        echo "❌ Error: requires Fedora 'Development Tools'" >&2
        echo "Build tools (like g++) not found. They are required for installing some Ruby gems."
        echo "install the 'Development Tools' group via dnf"
        echo "Please install them manually: sudo dnf groupinstall 'Development Tools'"
    fi

    if ! gem list -i "^jekyll$" > /dev/null; then
        echo "Installing Jekyll..."
        gem install jekyll bundler
        gem install logger
        mise reshim # so 'jekyll' and 'bundle' commands work
    fi

    echo "$(which bundle) $(bundle --version)"
    echo "$(which jekyll) $(jekyll --version)"
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_jekyll "$@"
fi
