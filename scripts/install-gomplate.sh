#!/bin/bash
set -e
set -o pipefail

function install_gomplate {
    if ! command -v gomplate &> /dev/null || ! gomplate --version &> /dev/null; then
        eget hairyhenderson/gomplate --to "$BIN_DIR/gomplate"
    fi
    (which gomplate && gomplate --version) || { echo "❌ Error: gomplate install failed" >&2; exit 1; }
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then install_gomplate "$@"; fi
