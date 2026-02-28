#!/bin/bash
set -e
set -o pipefail

SCRIPTROOT=$(dirname "${BASH_SOURCE[0]}") # Global
source "$SCRIPTROOT/lib/ide.sh"

main() {
    echo "--- ${0} ---"
    install_vscode vscode-updates/argv.json
    install_extensions vscodeExtensions
    configure_vscode vscode-updates/user-settings.json
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
