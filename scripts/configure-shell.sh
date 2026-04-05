#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to handle shell configuration
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

configure_shell() {
    # Detect the current shell from its name to locate the correct rc file.
    local shell_name=$(basename "$SHELL")
    local rc_file="$HOME/.${shell_name}rc"
    local pwsh_init="$SCRIPTROOT/dotnet/powershell.ps1"

    if [ "$OS_FAMILY" == "debian" ]; then
        local target_shell
        target_shell=$(which "$shell_name")
        if [ "$SHELL" != "$target_shell" ]; then
            echo "Changing user shell to $target_shell"
            sudo chsh -s "$target_shell" "$USER"
        fi

        # Add ~/.local/bin to path in rc_file
        if ! grep -q "PATH=" "$rc_file"; then
            echo "# Include bin dir in path; Move this to top!" >> "$rc_file"
            echo 'eval "export PATH=~/.local/bin:$PATH"' >> "$rc_file"
        fi

        # Posh exists? upgrade it! No posh, install it.
        if command -v oh-my-posh &> /dev/null; then
            oh-my-posh upgrade
        else
            curl -s https://ohmyposh.dev/install.sh | bash -s
        fi

        # Posh's config persists in shell's .rc file
        if ! grep -q "oh-my-posh init $shell_name" "$rc_file"; then
            echo "# Integrate Posh" >> "$rc_file"
            echo 'eval "$(oh-my-posh init '"$shell_name"' --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/pure.omp.json)"' \
                >> "$rc_file"
            echo "Persisting in $rc_file"
        fi

        # Configure Posh for Powershell
        if command -v pwsh &> /dev/null; then
            echo "pwsh $(pwsh --version)" 
            pwsh -NoProfile -File $pwsh_init
        else
            echo "Warning: pwsh not found. Skipping PowerShell configuration."
        fi

    elif [ "$OS_FAMILY" == "macos" ]; then
        if command -v oh-my-posh &> /dev/null; then
            oh-my-posh upgrade
        else
            brew install jandedobbeleer/oh-my-posh/oh-my-posh
        fi
    else
        echo "Unsupported platform."
    fi
    echo "Shell: $SHELL ($($SHELL --version | head -n 1))"
    echo "Prompt: oh-my-posh $(oh-my-posh version)"
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    configure_shell "$@"
fi
