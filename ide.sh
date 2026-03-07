#!/bin/bash
set -e
set -o pipefail

SCRIPTROOT=$(dirname "${BASH_SOURCE[0]}") # Global
source "$SCRIPTROOT/lib/ide.sh"

# Function that drives execution using config.yaml
main() {
    local config_file="$SCRIPTROOT/config.yaml"
    echo "--- ${0} ---"

    # Prerequisites: yq must be installed to continue
    if ! command -v yq &> /dev/null; then
        # install_apt_packages Aptfile
        install_yamljson
    fi

    # Extract enabled steps and loop through them
    local steps
    steps=$(yq -r '.ide[] | select(.enabled != false) | .name + " " + (.args | join(" "))' "$config_file")

    while read -r cmd; do
        if [ -n "$cmd" ]; then
            echo
            echo "--- $cmd ---"
            eval "$cmd"
        fi
    done <<< "$steps"
}

# Determine mode of operation
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--install)
            MODE="install"; echo "Install mode"; shift;;
        -h|--help)
            print_help; exit 0;;
        -u|--update)
            MODE="update";  echo "Update is not implemented"; echo; print_help; exit 1;;
        -g|--upgrade)
            MODE="upgrade"; echo "Upgrade is not implemented"; echo; print_help; exit 1;;
        -n|--dry-run|--noop|--whatif)
            MODE="dry-run"; echo "Dry run is not implemented"; echo; print_help; exit 1;;
        *)
            echo "Unknown option: $1"; echo; print_help; exit 1;;
    esac
done

if [ "$MODE" = "install" ]; then
    main "$@"
else
    print_help
fi
