#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Helper functions for UV
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function to install using UV (e.g. Ansible)
#   dependencies: install_uv
install_using_uv_with_executables_from() {
    local pkg_name="${1:-ansible}"
    local with_executables_from="${2:-ansible-core,ansible-lint}"
    local test_arg="${3:-localhost -m ping}"

# uv tool install --with-executables-from ansible-core,ansible-lint ansible
    if ! uv tool install --with-executables-from "$with_executables_from" "$pkg_name"; then
        echo "❌ Error: failed: 'uv tool install --with-executables-from $with_executables_from $pkg_name'"
        return 1
    fi

    # Integrity Verification
    # While uv verifies on download, we can manually check the binary path
    local pkg_path=$(which "$pkg_name" 2>/dev/null)
    if [[ -z "$pkg_path" ]]; then
        echo "❌ Error: $pkg_name binary not found in PATH."
        return 1
    fi
    "$pkg_name" --version | head -n 1
    echo "$pkg_path"

    # Functional Test
    echo "Ran test: '$pkg_name $test_arg'"
    if ! $pkg_name $test_arg > /dev/null 2>&1; then
        echo "❌ Error: functional test failed." >&2
        return 1
    fi
}
