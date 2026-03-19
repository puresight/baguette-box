#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   ⚠ Under Construction ⚠
#   -- Persistant Problem --
# 
# ```log`
# Flatpak 1.14.10
# Performing 'scorched earth' reset of Flatpak user data...
# Adding Flatpak remote 'flathub'...
# Warning: Could not update extra metadata for 'flathub': GPG verification enabled, but no summary found (check that the configured URL in remote config is correct)
# Name    Options
# flathub user
# Updating appstream data for user remote flathub
# Error updating: Error updating appstream2: No such ref 'appstream2/x86_64' in remote flathub; Error updating appstream: No such ref 'appstream/x86_64' in remote flathub
# error: Unable to load summary from remote flathub: GPG verification enabled, but no summary found (check that the configured URL in remote config is correct)
# ```
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------


# Function
#   TODO 2026/3 Bazaar app failed tests
_configure_flatpak() {
    local remote_name="${1:-flathub}"
    local remote_url="${2:-'https://dl.flathub.org/repo/flathub.flatpakrepo'}"
    local app_id="${3:-com.github.tchx84.Flatseal}"
    local delay_seconds=5
    local level="user" # not "system"
    local chromeos_vars=GSK_RENDERER=cairo LIBGL_ALWAYS_SOFTWARE=1 GTK_IM_MODULE=ibus

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
    flatpak install --$level -y --noninteractive $remote_name $app_id

    # Run Flatseal with tmux
    echo "Expect $app_id to open in $delay_seconds seconds"
    tmux new-session -d -s background_task \
        "sleep $delay_seconds && $chromeos_vars flatpak run $app_id > /dev/null 2>&1"
    tmux ls

    # ---
    # Functional Test: Bazaar failed.
    # Install Bazaar
    # flatpak install -y --user io.github.kolunmi.Bazaar
    # flatpak override --user io.github.kolunmi.Bazaar --talk-name=org.freedesktop.Flatpak
    # flatpak override --user io.github.kolunmi.Bazaar --filesystem=/var/scripts/flatpak:ro
    # Run Bazaar
    # GSK_RENDERER=cairo LIBGL_ALWAYS_SOFTWARE=1 GTK_IM_MODULE=ibus flatpak run io.github.kolunmi.Bazaar
}
