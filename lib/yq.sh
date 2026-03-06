#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#   Dependencies:
#       - jq (Aptfile)
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

install_yq() {
    local BIN_DIR="$HOME/.local/bin"
    local REPO="mikefarah/yq"
    local ARCH

    case "$(uname -m)" in
        x86_64) ARCH="amd64" ;;
        aarch64) ARCH="arm64" ;;
        armv7l) ARCH="arm" ;;
        *) echo "Unsupported architecture"; return 1 ;;
    esac

    mkdir -p "$BIN_DIR"

    local LATEST_VERSION=$(curl -sI https://github.com/${REPO}/releases/latest | grep -i "location:" | awk -F'/' '{print $NF}' | tr -d '\r\n')
    
    if [ -z "$LATEST_VERSION" ]; then
        echo "Error: Could not fetch latest yq version."
        return 1
    fi

    if command -v yq >/dev/null 2>&1; then
        local CURRENT_VERSION=$(yq --version | awk '{print $NF}')
        if [[ "$CURRENT_VERSION" == "$LATEST_VERSION" ]]; then
            # echo "yq is already up-to-date ($CURRENT_VERSION)."
            yq --version
            return 0
        fi
    fi

    local TMP_DIR=$(mktemp -d)
    # yq releases use 'yq_linux_amd64' for the binary
    local BIN_NAME="yq_linux_${ARCH}"
    local DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${LATEST_VERSION}/${BIN_NAME}"
    local CHECKSUM_URL="https://github.com/${REPO}/releases/download/${LATEST_VERSION}/checksums"

    echo "Downloading yq $LATEST_VERSION..."
    curl -sL "$DOWNLOAD_URL" -o "${TMP_DIR}/yq_bin"

    # echo "Verifying checksums..."
    # curl -sL "$CHECKSUM_URL" -o "${TMP_DIR}/checksums"
    # TODO: Implement robust checksum verification for yq's multi-hash manifest format.
    # The 'checksums' file currently contains MD5, SHA1, and SHA256 in a non-standard layout.
    
    chmod +x "${TMP_DIR}/yq_bin"
    mv "${TMP_DIR}/yq_bin" "${BIN_DIR}/yq"
    rm -rf "$TMP_DIR"

    echo "Installed at $BIN_DIR/yq"
    "$BIN_DIR/yq" --version
}
