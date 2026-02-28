#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#   This library script has functions that install Nerd Fonts.
#
#   Dependencies:
#   - unzip
#   - fontconfig (fc-cache command)
#   - PLATFORM global variable
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function to download and install a Nerd Font
# Parameters: $1 - font name, $2 - version
install_nerd_font() {
    # Arguments
    local font_name="${1:-JetBrainsMono}"
    local version="${2:-v3.3.0}"
    local fonts_dir="${3:-"$HOME/.local/share/fonts"}"

    echo "${FUNCNAME[0]}"

    # TODO support multiple platforms like macos    
    if ! [ "$PLATFORM" == "linux" ]; then
        echo "Fonts not supported on $PLATFORM" >&2
        return 1
    fi

    # Internal variables
    local base_tmp="${TMPDIR:-/tmp}"
    local font_zip="${font_name}.zip"
    local download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/${font_zip}"
    local temp_file="${base_tmp}/${font_zip}"

    # Check for a specific file to avoid re-downloading. 
    # Most Nerd Fonts include a "Nerd Font" suffix in the filename.
    if ls "${fonts_dir}/${font_name}"*"NerdFont"* >/dev/null 2>&1; then
        echo "$font_name is already installed."
        return
    fi

    echo "Installing $font_name Nerd Font ($version)..."

    # Preparation
    mkdir -p "$fonts_dir" || {
        echo "Error: Failed to create font directory at $fonts_dir" >&2
        return 1
    }

    # Download
    echo "Downloading $font_name from GitHub..."
    if ! curl -sfLo "$temp_file" "$download_url"; then
        echo "Error: Failed to download font from $download_url" >&2
        return 1
    fi

    # Extraction
    echo "Extracting files to $fonts_dir..."
    if ! unzip -qjo "$temp_file" -d "$fonts_dir"; then
        echo "Error: Failed to extract $temp_file" >&2
        rm -f "$temp_file"
        return 1
    fi

    # Cleanup and Refresh Cache
    rm -f "$temp_file"
    echo "Updating font cache..."
    if ! fc-cache -f; then
        echo "Warning: fc-cache failed to refresh. Manual intervention may be required." >&2
    else
        echo "Font installation complete."
    fi
}

# Execute install_nerd_font function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_nerd_font "$@"
fi
