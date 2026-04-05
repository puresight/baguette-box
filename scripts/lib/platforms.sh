#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Purpose:
#
#   - Error if no internet connection
#   - Error if known incompatible platform
#   - Warning if unknown compatible platforms
#   - Set global $OS_FAMILY variable to the OS family name e.g. "debian"
#   - Set global $OS_NAME variable to the OS name e.g. "Bluefin"

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Method of OS identification:
#
# - Unix: compare output of command: `uname -r`
# - Linux: source the file: /etc/os-release
#   - Debian: variable $ID == "debian"
#   - Fedora: variable $ID == "fedora" && file exists: /etc/fedora-release
#     - Atomic: if [ -f /run/ostree-booted ]
#     - Universal Blue:
#         - if command -v ujust, and
#         - variable $CPE_NAME contains "/o:universal-blue"
#       - Bluefin/etc:
#           - variable VARIANT_ID contains bluefin|bazzite|aurora|ucore, or
#           - variable CPE_NAME contains bluefin|bazzite|aurora|ucore
#       - uCore: if command -v ucore-update

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Function returns number of evidences that the system is a Crostini
check_crostini() {
    local crostini=0

    local GUEST_TOOLS=("garcon" "sommelier")
    for cmd in "${GUEST_TOOLS[@]}"; do
        if command -v "$cmd" >/dev/null 2>&1; then
            # printf "Found $cmd which is a Crostini guest tool command\n"
            ((crostini++))
        fi
    done

    if [ -d /dev/wl0 ] || [ -d /proc/sys/fs/binfmt_misc/WSLInterop ]; then
        # printf "Found a device node used on Crostini\n"
        ((crostini++))
    fi

    if [ -n "$vsh_id" ]; then
        # printf "Found vsh_id environment variable, which is typical on Crostini\n"
        ((crostini++))
    fi

    echo "$crostini"
}

# Try it out
[ $(check_crostini) -ge 4 ] && echo " *** *** *** *** *** System is probably a Chromebook. *** *** *** *** ***"

# if exists, source the /etc/os-release
[[ -f /etc/os-release ]] && . /etc/os-release

# Check the Unix kernel identification
case "$(uname -s)" in
    Darwin*)
        OS_FAMILY="macos"
        printf "❌ Error: $OS_FAMILY is not supported\n" >&2
        exit 1
        sw_vers
        ;;
    FreeBSD*)
        OS_FAMILY="freebsd"
        printf "❌ Error: $OS_FAMILY is not supported\n" >&2 &&
        exit 1
        cat /etc/freebsd-update.conf
        ;;
    Linux*)
        OS_FAMILY=${ID_LIKE:-$ID}  # Prefer ID_LIKE e.g. fedora|debian
        ;;
    *)
        OS_FAMILY="unknown"
        printf "❌ Error: OS is not supported\n" >&2
        exit 1
        ;;
esac

# Check the Linux distro identification
case $OS_FAMILY in
    fedora*)
        #   mutable?: dnf install
        # immutable?: rpm-ostree install
        # ---------
        # printf "platform: $OS_FAMILY $VARIANT $VARIANT_ID\n" # e.g. fedora Silverblue bluefin-dx-nvidia-open
        if [[ "Silverblue" == "$VARIANT" ]]; then
            OS_FAMILY=ublue
            return # pass
        fi
        printf "Warning: $OS_FAMILY is not fully tested\n" >&2
        ;;
    "ubuntu debian")
        printf "Warning: $ID is untested\n" >&2
        return # pass
        ;;
esac

# Warn if not debian.
# Because this is an unexpected use of this program, the intent is to hang execution
# to wait on interactive user confirmation to continue despite the warning.
if [ "$OS_FAMILY" != "debian" ]; then
    printf "Warning: '$OS_FAMILY' is not a supported OS.\n" >&2
    read -p "Continue anyway? (y/N) " -r choice
    # Default to 'No' if input does not start with 'y' or 'Y'
    if [[ ! "$choice" =~ ^[Yy] ]]; then
        echo "Aborting."
        exit 1
    fi
    echo "Proceeding at your own risk..."
fi
