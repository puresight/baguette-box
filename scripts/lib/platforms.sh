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

# Unix kernel identity
OS_TYPE="$(uname -s)"
# printf "$OS_TYPE "
case $OS_TYPE in
    Linux*)
        ;;
    Darwin*)
        OS_FAMILY="macos"
        printf "❌ Error: $OS_TYPE is not supported\n" >&2
        exit 1
        sw_vers
        ;;
    FreeBSD*)
        OS_FAMILY="freebsd"
        printf "❌ Error: $OS_TYPE is not supported\n" >&2
        exit 1
        cat /etc/freebsd-update.conf
        ;;
    *)
        printf "❌ Error: $OS_TYPE is not supported\n" >&2
        exit 1
        ;;
esac

# error if no /etc/os-release
[[ ! -f /etc/os-release ]] && echo "❌ Error: file not found: /etc/os-release" && exit 1
# Check the Linux distro identification
. /etc/os-release
# Linux family
OS_FAMILY=${ID_LIKE:-$ID}  # prefer ID_LIKE e.g. fedora

case $OS_FAMILY in
    fedora*)
        if [ -n "$OSTREE_VERSION" ]; then
            OS_KIND=atomic
            # "$OS_FAMILY $VARIANT $VARIANT_ID" # e.g. fedora Silverblue bluefin-dx-nvidia-open
            # "cpe:/o:universal-blue:bluefin:43" cut with ':' as the delimiter, Field 3 = Project, Field 4 = Product, Field 5 = Version
            PROJECT=$(echo "$CPE_NAME" | cut -d: -f3)
            PRODUCT=$(echo "$CPE_NAME" | cut -d: -f4)
            # VERSION=$(echo "$CPE_NAME" | cut -d: -f5)
            if [[ "$PROJECT" == *"universal-blue"* ]]; then
                OS_FAMILY=ublue
                OS_NAME=$PRODUCT # e.g. bazzite|aurora|bluefin
                return # ublue gets a pass
            else # not ublue
                OS_NAME=$VARIANT_ID # e.g. silverblue|kenoite|sericea|onyx|sway
                printf "Warning: $OS_FAMILY $OS_NAME is not fully tested\n" >&2
            fi
        else # not atomic
            OS_NAME=$VARIANT_ID # e.g. workstation|server|kde|xfce
            printf "Warning: $OS_FAMILY $OS_NAME is untested\n" >&2
        fi
        ;;
    "ubuntu debian"|"ubuntu")
        printf "Warning: $OS_FAMILY is untested\n" >&2
        OS_FAMILY=debian
        ;;
esac

# Warn & interrupt if not debian
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

# Debian

check_crostini() {
    # Gather number of evidences that the system is a Crostini
    local crostini=0

    if [ "Linux" == "$OS_TYPE" ]; then
        # APT must be available
        if command -v apt &> /dev/null; then
            # Check for Guest Tools
            local GUEST_TOOLS=("garcon" "sommelier")
            for cmd in "${GUEST_TOOLS[@]}"; do
                if command -v "$cmd" >/dev/null 2>&1; then
                    # printf "Found $cmd which is a Crostini guest tool command\n"
                    ((crostini++))
                fi
            done

            # Check particular ports
            if [ -d /dev/wl0 ] || [ -d /proc/sys/fs/binfmt_misc/WSLInterop ]; then
                # printf "Found a device node used on Crostini\n"
                ((crostini++))
            fi

            # Check env vars
            if [ -n "$vsh_id" ]; then
                # printf "Found vsh_id environment variable, which is typical on Crostini\n"
                ((crostini++))
            fi
        fi # APT
    fi # OS_TYPE
    echo "$crostini"
}

if [ $(check_crostini) -ge 1 ]; then
    OS_NAME="chromeos"
    # printf "\n*** platform detected: $OS_FAMILY $OS_NAME\n\n"
fi
