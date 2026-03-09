#!/bin/bash

# TODO eget
# Function to install MinIO Client (mc)
install_minio_client() {
    local BINARY_NAME="mc"
    local BASE_URL="https://dl.min.io/client/mc/release"

    # Detect Architecture
    # Maps standard uname output to MinIO's expected format
    case $(uname -m) in
        x86_64)  ARCH="linux-amd64" ;;
        aarch64) ARCH="linux-arm64" ;;
        arm*)    ARCH="linux-arm" ;; # Fallback for older ARM
        ppc64le) ARCH="linux-ppc64le" ;;
        *)       echo "❌ Error: Unsupported architecture $(uname -m)"; return 1 ;;
    esac
    echo "🔍 Detected Architecture: $ARCH"

    # Prepare Temporary Directory
    local TMP_DIR=$(mktemp -d)
    # echo "📂 Working in temp dir: $TMP_DIR"

    # Download Binary & Checksum
    # Uses -f (--fail) to exit on 404/500 errors
    # Uses -sS (silent but show errors) for clean output
    echo "⬇️  Downloading MinIO Client..."
    
    if ! curl -f -sS -o "$TMP_DIR/$BINARY_NAME" "$BASE_URL/$ARCH/$BINARY_NAME"; then
        echo "❌ Error: Failed to download binary. Check network or URL."
        rm -rf "$TMP_DIR"
        return 1
    fi

    if ! curl -f -sS -o "$TMP_DIR/$BINARY_NAME.sha256sum" "$BASE_URL/$ARCH/$BINARY_NAME.sha256sum"; then
        echo "❌ Error: Failed to download checksum file."
        rm -rf "$TMP_DIR"
        return 1
    fi

    # Verify Checksum
    # MinIO checksum files often contain the full release name (e.g., mc.RELEASE...), 
    # causing standard 'sha256sum -c' to fail on the renamed 'mc' file.
    # We extract just the hash and compare manually.
    
    echo "🔐 Verifying Checksum..."
    local EXPECTED_HASH=$(awk '{print $1}' "$TMP_DIR/$BINARY_NAME.sha256sum")
    local CALCULATED_HASH=$(sha256sum "$TMP_DIR/$BINARY_NAME" | awk '{print $1}')

    if [ "$EXPECTED_HASH" != "$CALCULATED_HASH" ]; then
        echo "❌ CRITICAL: Checksum Mismatch!"
        echo "   Expected:   $EXPECTED_HASH"
        echo "   Calculated: $CALCULATED_HASH"
        rm -rf "$TMP_DIR"
        return 1
    fi
    echo "✅ Checksum Verified: $EXPECTED_HASH"

    # Install
    chmod +x "$TMP_DIR/$BINARY_NAME"
    
    echo "📦 Installing to $BIN_DIR..."
    if mv "$TMP_DIR/$BINARY_NAME" "$BIN_DIR/$BINARY_NAME"; then
        echo "🎉 Success! MinIO Client installed."
        rm -rf "$TMP_DIR"
        # Verify execution
        "$BIN_DIR/$BINARY_NAME" --version
    else
        echo "❌ Error: Failed to move binary. Check permissions."
        rm -rf "$TMP_DIR"
        return 1
    fi
}

# Invoke function only if script is executed directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_minio_mc
fi
