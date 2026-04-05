#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#       Function to install a Nerd Font
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_font() {
    local font_id="${1:-JetBrainsMono}"
    local font_version="${2:-v3.3.0}"
    local font_zip="${font_id}.zip"
    local font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${font_version}/${font_zip}"
    local font_dir="$HOME/.local/share/fonts/${font_id}"

    if [ "$OS_FAMILY" != "debian" ] && [ "$OS_FAMILY" != "ublue" ]; then
        echo "Skipping font installation (unsupported platform $OS_FAMILY)."
        return 0
    fi

    if [ ! -d "$font_dir" ]; then
        echo "Installing $font_id font..."
        mkdir -p "$font_dir"
        curl -sL "$font_url" -o "/tmp/$font_zip"
        unzip -q "/tmp/$font_zip" -d "$font_dir"
        rm "/tmp/$font_zip"
        
        if command -v fc-cache &> /dev/null; then
            fc-cache -fv
        fi
        echo "✓ Installed $font_id Nerd Font."
    else
        echo "$font_id font is already installed."
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_font "$@"
fi
