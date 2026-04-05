#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to install and configure fzf and zoxide terminal tools
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

install_terminal_tools() {
    # Detect the current shell from its name to locate the correct rc file.
    local shell_name=$(basename "$SHELL")
    local rc_file="$HOME/.${shell_name}rc"

    echo "${FUNCNAME[0]}"

    # --- Install fzf ---
    # We use git clone and the official install script because it's the most
    # reliable way to set up shell integration (key bindings, completion).
    if [ ! -d "$HOME/.fzf" ]; then
        echo "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        # The --all flag installs for bash, zsh, and fish non-interactively.
        # It adds the necessary source line to the shell's rc file.
        "$HOME/.fzf/install" --all
    else
        echo "fzf appears to be installed (found ~/.fzf)."
    fi
    export PATH="$PATH:$HOME/.fzf/bin"
    echo "fzf $(fzf --version)"

    # --- Install zoxide ---
    if ! command -v zoxide &> /dev/null; then
        mise use -g zoxide@latest
    else
        echo "zoxide is already installed."
    fi
    zoxide --version

    # --- Configure zoxide ---
    # This adds the necessary hook to the shell's rc file to make zoxide work.
    # The hook enables 'z' to work and integrates with fzf automatically if found.
    if ! grep -q "zoxide init" "$rc_file"; then
        echo "Configuring zoxide for $shell_name..."
        echo '' >> "$rc_file"
        echo '# Initialize zoxide for smart directory changing' >> "$rc_file"
        echo 'eval "$(zoxide init '"$shell_name"')"' >> "$rc_file"
        echo "zoxide configured in $rc_file."
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_terminal_tools "$@"
fi
