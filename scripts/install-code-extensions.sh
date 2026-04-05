#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to install VS Code extensions
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_code_extensions() {
    local ext_file="${1:-code/code.Extensions}"
    local ext_path="$SCRIPTROOT/$ext_file"

    if [ -f "$ext_path" ]; then
        while IFS= read -r extension || [ -n "$extension" ]; do
            # Ignore comments and empty lines
            [[ "$extension" =~ ^#.*$ ]] && continue
            [[ -z "$extension" ]] && continue
            echo "+extension: $extension"
            code --install-extension "$extension"
        done < "$ext_path"
    else
        echo "❌ Error: $ext_path file not found! skipping it." >&2
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_code_extensions "$@"
fi
