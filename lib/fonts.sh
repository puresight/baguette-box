#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#   This library script has functions that install Nerd Fonts.
#   Dependencies: unzip
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function to download and install a Nerd Font
# Parameters: $1 - font name, $2 - version
install_nerd_font() {
    # Arguments
    local font_name="${1:-JetBrainsMono}"
    local version="${2:-v3.3.0}"
    
    # Internal variables
    local base_tmp="${TMPDIR:-/tmp}"
    local font_zip="${font_name}.zip"
    local download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/${font_zip}"
    local target_dir="$HOME/.local/share/fonts"
    local temp_file="${base_tmp}/${font_zip}"

    # Check for a specific file to avoid re-downloading. 
    # Most Nerd Fonts include a "Nerd Font" suffix in the filename.
    if ls "${target_dir}/${font_name}"*"NerdFont"* >/dev/null 2>&1; then
        echo "$font_name Nerd Font appears to be already installed."
        return 0
    fi

    echo "Installing $font_name Nerd Font ($version)..."

    # Preparation
    mkdir -p "$target_dir" || {
        echo "Error: Failed to create font directory at $target_dir" >&2
        return 1
    }

    # Download
    echo "Downloading $font_name from GitHub..."
    if ! curl -sfLo "$temp_file" "$download_url"; then
        echo "Error: Failed to download font from $download_url" >&2
        return 1
    fi

    # Extraction
    echo "Extracting files to $target_dir..."
    if ! unzip -qjo "$temp_file" -d "$target_dir"; then
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
