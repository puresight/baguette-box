#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to configure VS Code settings
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"
. "$SCRIPTROOT/scripts/lib/json.sh"

configure_code() {
    local repo_path="$SCRIPTROOT"
    local settings_file="${1:-code/user-settings.json}"

    local vscode_user_settings="$repo_path/$settings_file"
    local target_json="$HOME/.config/Code/User/settings.json"
    if [ "macos" == "$OS_FAMILY" ]; then
        target_json="$HOME/Library/Application Support/Code/User/settings.json"
    fi

    if [ -n "$target_json" ]; then
        mkdir -p "$(dirname "$target_json")"
        update_json "$vscode_user_settings" "$target_json"
        if [ $? -ne 0 ]; then
            echo "❌ Error: settings update failed." >&2
            exit 1
        fi
        echo "done"
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    configure_code "$@"
fi
