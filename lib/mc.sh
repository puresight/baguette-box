#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Exported function: install_minio_client
#
#   Private functions
#   -  install_minio_client_from_binary
#   -  install_minio_client_from_source
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------



# Private Function to install MinIO Client (mc) from the last available binary release.
# This is used as a fallback if building from source fails.
install_minio_client_from_binary() {
    if ! command -v eget &> /dev/null; then
        echo "Error: eget is not installed. Please run install_eget first."
        return 1
    fi

    echo "Attempting to install last available MinIO Client binary using eget..."
    mkdir -p "$BIN_DIR"
    # eget automatically handles architecture detection, download, and checksum verification.
    if eget minio/mc --to "$BIN_DIR/mc"; then
        echo "🎉 Success! Fallback to binary installation of MinIO Client succeeded."
        "$BIN_DIR/mc" --version
        return 0
    else
        echo "❌ Error: Failed to install MinIO Client using the binary fallback."
        return 1
    fi
}

# Private Function to build and install the latest MinIO Client (mc) from source.
install_minio_client_from_source() {
    if ! command -v go &> /dev/null; then
        echo "Go compiler not found. Cannot build 'mc' from source."
        return 1
    fi

    echo "Building latest MinIO Client (mc) from source..."
    local TMP_DIR=$(mktemp -d)
    if [ -z "$TMP_DIR" ]; then
        echo "❌ Error: Failed to create temporary directory."
        return 1
    fi

    # Ensure cleanup happens on exit or error
    trap 'rm -rf "$TMP_DIR"' RETURN

    echo "Cloning minio/mc repository..."
    if ! git clone --depth 1 https://github.com/minio/mc.git "$TMP_DIR"; then
        echo "❌ Error: Failed to clone the repository."
        return 1
    fi

    local repo_size=$(du -sh "$TMP_DIR" | cut -f1)
    local file_count=$(find "$TMP_DIR" -type f | wc -l)
    echo "📦 Source code size: $repo_size ($file_count files)."
    echo "⏳ Compiling... (This typically takes 1-3 minutes on most systems)"

    (
        cd "$TMP_DIR" || return 1
        if go build -o "$BIN_DIR/mc"; then
            echo "🎉 Success! MinIO Client built from source and installed."
            "$BIN_DIR/mc" --version
        else
            echo "❌ Error: Go build failed."
            return 1
        fi
    )
}

# Public Function to install MinIO Client (mc).
# It first tries to build from source, and falls back to downloading the last binary.
install_minio_client() {
    echo "Installing/Updating MinIO Client (mc)..."
    mkdir -p "$BIN_DIR"

    install_minio_client_from_source || {
        echo "Build from source failed. Falling back to binary download."
        install_minio_client_from_binary
    }
}

# Invoke function only if script is executed directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # This requires BIN_DIR to be set, e.g., export BIN_DIR="$HOME/.local/bin"
    install_minio_client
fi
