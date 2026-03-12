#!/bin/bash
set -e
set -o pipefail

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#   This is the entry point. Read the docs to understand how
#   to drive it with YAML configuration.
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# GLobal variables
SCRIPTROOT=$(dirname "${BASH_SOURCE[0]}")
BIN_DIR="$HOME/.local/bin"

# Ensure BIN_DIR is first in PATH for newly installed tools
# export PATH="$BIN_DIR:$PATH"

. "$SCRIPTROOT/lib/bootstrap.sh"
. "$SCRIPTROOT/lib/code.sh"

# Prerequisites
if ! command -v eget &> /dev/null; then
    install_eget
fi
# eget --version || { echo "❌ Error: eget install failed" >&2; exit 1; }

# Install gomplate
if ! command -v gomplate &> /dev/null || ! gomplate --version &> /dev/null; then
    eget hairyhenderson/gomplate --to "$BIN_DIR/gomplate"
fi
(which gomplate && gomplate --version) || { echo "❌ Error: gomplate install failed" >&2; exit 1; }

# Function
do_yaml() {
    local config_file="$1"
    echo "--- $config_file ---"

    local steps
    steps=$(gomplate \
        --datasource "config=$config_file" \
        --in '{{- range (ds "config").tasks -}}{{- if or (not (coll.Has . "enabled")) .enabled -}}{{ .task }}{{ if coll.Has . "arguments" }}{{- range .arguments }} {{ . | quote }}{{ end }}{{ end }}{{ "\n" }}{{- end -}}{{- end -}}' \
    )
    while read -r task_cmd; do
        if [ -n "$task_cmd" ]; then
            local func_name="${task_cmd%% *}"
            if declare -F "$func_name" > /dev/null; then
                echo
                echo "--- $task_cmd ---"
                eval "$task_cmd"
            else
                echo "❌ Error: invalid task name: correct '$func_name' in $config_file" >&2
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
            MODE="install"; echo "Mode: $MODE"; shift;;
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
        echo "❌ Error: --config <file> is required."
        print_help
        exit 1
    fi
    do_yaml "$CONFIG_FILE"
else
    print_help
fi
