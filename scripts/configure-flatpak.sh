#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to configure Flatpak
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

configure_flatpak() {
    # echo "sorry: flatpak is disabled for troubleshooting."
    # return
    _configure_flatpak "$@"
}

# Function
#   TODO 2026/3 Bazaar app failed tests
_configure_flatpak() {
    local remote_name="${1:-flathub}"
    local remote_url="${2:-'https://dl.flathub.org/repo/flathub.flatpakrepo'}"
    local app_id="${3:-com.github.tchx84.Flatseal}"
    local delay_seconds=5
    local level="user" # not "system"
    local chromeos_vars="GSK_RENDERER=cairo LIBGL_ALWAYS_SOFTWARE=1 GTK_IM_MODULE=ibus"

    if ! command -v flatpak &> /dev/null; then
        echo "Warning: flatpak not found. Skipping configuration."
        return 0
    fi

    flatpak --version

    # On some systems, particularly Crostini on Chromebooks, the flatpak cache or
    # installation can become corrupted. This can lead to GPG and ref errors.
    # As a last resort, we perform a "scorched earth" removal of the entire user
    # flatpak directory to ensure a completely fresh start. This will remove all
    # user-installed Flatpak apps and remotes.
    echo "Performing 'scorched earth' reset of Flatpak user data..."
    rm -rf ~/.cache/flatpak
    rm -rf ~/.local/share/flatpak

    echo "Adding Flatpak remote '$remote_name'..."
    flatpak remote-add --$level --if-not-exists "$remote_name" "$remote_url"
    flatpak remotes

    # -- Update metadata --
    # Note: Flatpak needs to pull the latest metadata (AppStream data). In Crostini, this can sometimes hang if done through the GUI, so it's best to trigger it manually first.
    # sudo flatpak update --appstream
    flatpak update --$level --appstream

    # Functional Test: Flatseal, docs https://github.com/tchx84/Flatseal/blob/master/DOCUMENTATION.md
    # Install Flatseal
    flatpak install --$level -y --noninteractive "$remote_name" "$app_id"

    # Run Flatseal with tmux
    if command -v tmux &> /dev/null; then
        echo "Expect $app_id to open in $delay_seconds seconds"
        tmux new-session -d -s background_task \
            "sleep $delay_seconds && $chromeos_vars flatpak run $app_id > /dev/null 2>&1"
        tmux ls
    else
        echo "Warning: tmux not found. Skipping functional test."
    fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    configure_flatpak "$@"
fi
