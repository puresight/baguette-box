#!/bin/bash

OS_TYPE=$(uname -s)
PLATFORM="unknown"
if [ "$OS_TYPE" == "Darwin" ]; then
    PLATFORM="macos"
elif [ "$OS_TYPE" == "Linux" ]; then
    PLATFORM="linux"
fi

# Function ------------------------------------------------------------
LOG_UNSUPPORTED() {
    echo "ERROR: Unsupported platform ($OS_TYPE / $PLATFORM). Only Linux (Crostini/Debian) and MacOS are supported." >&2
    exit 1
}

if [ "$PLATFORM" == "unknown" ]; then
    LOG_UNSUPPORTED
fi
# Needed for UPDATE_JSON
if command -v npm &> /dev/null; then
    echo "Uses jsonc-cli"
    npm install -g jsonc-cli
else
    # caller is not ready to continue so
    return
fi

# Function ------------------------------------------------------------
UPDATE_JSON() {
    local source_file="$1"
    local target_file="$2"

    # Arguments
    echo "Source: $source_file"
    echo "Target: $target_file"

    # Existence Logic
    if [[ ! -f "$source_file" && ! -f "$target_file" ]]; then
        echo "Error: files not found." >&2
        return 1
    fi
    if [[ ! -f "$source_file" ]]; then
        echo "Source not found."
        return 0
    fi
    if [[ ! -f "$target_file" ]]; then
        echo "Target not found. Initializing from source."
        cp "$source_file" "$target_file"
        return 0
    fi

    # Setup stable temp files
    local clean_news
    local clean_record
    local merged_output
    
    clean_news=$(mktemp)
    clean_record=$(mktemp)
    merged_output=$(mktemp)
    
    trap 'rm -f "$clean_news" "$clean_record" "$merged_output"' EXIT

    # Convert both to clean JSON using jsonc-cli
    # This strips comments and handles the JSONC format
    if ! cat "$source_file" | jsonc read "" > "$clean_news"; then
        echo "Error: Failed to parse source JSONC." >&2
        return 1
    fi
    if ! cat "$target_file" | jsonc read "" > "$clean_record"; then
        echo "Error: Failed to parse target JSONC." >&2
        return 1
    fi

    # Atomic Merge with jq
    # The '*' operator merges top-level keys (a shallow merge).
    # Use 'recursive_merge' (//) or deep-merge functions if you ever need nesting.
    if jq -s '.[0] * .[1]' "$clean_record" "$clean_news" > "$merged_output"; then
        # Format the final result back to the target file
        cat "$merged_output" | jsonc format > "$target_file"
        echo "Update successful."
    else
        echo "Error: jq merge failed." >&2
        return 1
    fi
}
