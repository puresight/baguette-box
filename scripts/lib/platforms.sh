#!/bin/bash

# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
# Purpose:
#   - Error if no internet connection
#   - Error if known incompatible platform
#   - Warning if unknown compatible platforms
#   - Set global $OS variable to the OS family name e.g. "debian"
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
        OS="macos"
        printf "❌ Error: $OS is not supported\n" >&2 && exit 1
        sw_vers
        ;;
    FreeBSD*)
        OS="freebsd"
        printf "❌ Error: $OS is not supported\n" >&2 && exit 1
        cat /etc/freebsd-update.conf
        ;;
    Linux*)
        OS=${ID_LIKE:-$ID}  # Prefer ID_LIKE e.g. fedora|debian
        ;;
    *)
        OS="unknown"
        printf "❌ Error: $OS is not supported\n" >&2 && exit 1
        ;;
esac

# Check the Linux distro identification
case $OS in
    fedora*)
        #   mutable?: dnf install
        # immutable?: rpm-ostree install
        printf "platform: $OS $VARIANT $VARIANT_ID\n" # e.g. fedora Silverblue bluefin-dx-nvidia-open
        ;;
    "ubuntu debian")
        printf "Warning: $ID is not tested\n" >&2
        ;;
esac

# Warn if not debian
if [ "$OS" != "debian" ]; then
    printf "Warning: $OS is not supported.\n" >&2
    read -p "You should abort now. Do you want to continue anyway? (y)Yes/(n)No : " choice
    case $choice in
        [yY]* ) echo "Ok, you were warned." ;;
        [nN]* ) echo "Aborting." && exit 1 ;;
        *) exit ;;
    esac
fi
