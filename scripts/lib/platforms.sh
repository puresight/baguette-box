#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# Purpose:
#   - Error if no internet connection
#   - Error if known incompatible platform
#   - Warning if unknown compatible platforms
#   - Set global $OS_FAMILY variable to the OS family name e.g. "debian"
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Halt if no internet connection
(timeout 2 bash -c 'exec 3<>/dev/tcp/detectportal.firefox.com/80') 2>/dev/null # Assumed: Firefox still operates its captive portal website
if [ $? -ne 0 ]; then
    printf "\n❌ Error: disconnected from the Internet. Check your connection and try again.\n\n" >&2 && exit 1
fi

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
        printf "Warning: $OS_FAMILY is not fully tested\n" >&2
        if [[ "Silverblue" == "$VARIANT" ]]; then
            return # pass
        fi
        ;;
    "ubuntu debian")
        printf "Warning: $ID is untested\n" >&2
        return # pass
        ;;
esac

# Warn if not debian
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
