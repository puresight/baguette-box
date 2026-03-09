#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#   This library script has a function to install Eget.
#   Dependencies:
#   - Github CLI
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

#Function
install_eget() {
    # 1. Define the installation directory
    local BIN_DIR="$HOME/.local/bin"
    mkdir -p "$BIN_DIR"

    # Create a temporary directory for the download to keep things tidy
    local TMP_DIR
    TMP_DIR=$(mktemp -d)
    pushd "$TMP_DIR" > /dev/null || return

    echo "Downloading Eget via GitHub CLI..."
    # --clobber: overwrite local file if it exists
    # -p: pattern to match Linux 64-bit archive
    if gh release download -R zyedidia/eget -p "*linux_amd64.tar.gz" --clobber; then
        
        echo "Extracting binary..."
        tar -xzf eget_*_linux_amd64.tar.gz
        
        # Move binary and ensure it is executable
        mv eget "$BIN_DIR/eget"
        chmod +x "$BIN_DIR/eget"
        
        echo "Successfully installed Eget to $BIN_DIR"
    else
        echo "Error: Failed to download Eget. Ensure 'gh' is authenticated."
        popd > /dev/null || return
        return 1
    fi

    # 2. Cleanup and return
    popd > /dev/null || return
    rm -rf "$TMP_DIR"

    # 3. Path check
    if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
        echo "NOTE: Add 'export PATH=\"\$HOME/.local/bin:\$PATH\"' to your ~/.bashrc"
    fi
}
