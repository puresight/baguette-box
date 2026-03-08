#!/bin/bash
set -e
set -o pipefail

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#   This script is the main entry point. Read the docs to understand
#   how to drive it through YAML configuration.
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

SCRIPTROOT=$(dirname "${BASH_SOURCE[0]}") # Global var
source "$SCRIPTROOT/lib/bootstrap.sh"
source "$SCRIPTROOT/lib/code.sh"

# Function that drives execution using config file
main() {
    local config_file="$1"
    echo "--- ${0} $config_file ---"

    # Prerequisites: yq must be installed to continue
    if ! command -v yq &> /dev/null; then
        # install_apt_packages Aptfile
        install_yamljson
    fi

    # Extract enabled steps and loop through them
    local steps
    steps=$(yq -r '.tasks[] | select(.enabled != false) | .task + " " + (.arguments | join(" "))' "$config_file")

    while read -r cmd; do
        if [ -n "$cmd" ]; then
            local func_name="${cmd%% *}"
            if declare -F "$func_name" > /dev/null; then
                echo
                echo "--- $cmd ---"
                eval "$cmd"
            else
                echo "Error: invalid task name: correct '$func_name' in $config_file" >&2
                exit 1
            fi
        fi
    done <<< "$steps"
}

# -- Handle Arguments --

# Determine mode of operation; the default is help.
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--install)
            MODE="install"; echo "Install mode"; shift;;
        -c|--config)
            CONFIG_FILE="$2"; shift 2;;
        -h|--help)
            MODE="help"; print_help; exit 0;;
        -u|--update)
            MODE="update";  echo "Update is not implemented"; echo; print_help; exit 1;;
        -g|--upgrade)
            MODE="upgrade"; echo "Upgrade is not implemented"; echo; print_help; exit 1;;
        -n|--dry-run|--noop|--whatif)
            MODE="dry-run"; echo "Dry run is not implemented"; echo; print_help; exit 1;;
        -*)
            echo "Unknown option: $1"; echo; print_help; exit 1;;
        *)
            CONFIG_FILE="$1"; shift;;
    esac
done

if [ -z "$MODE" ] && [ -n "$CONFIG_FILE" ]; then
    MODE="install"
fi

if [ "$MODE" = "install" ]; then
    if [ -z "$CONFIG_FILE" ]; then
        echo "Error: --config <file> is required."
        print_help
        exit 1
    fi
    main "$CONFIG_FILE"
else
    print_help
fi
