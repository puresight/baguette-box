#!/bin/bash

# Global variables
PLATFORM="unknown"

case "$(uname -s)" in
    Darwin*)
        PLATFORM="macos"    # Unsupported
        sw_vers
        ;;
    FreeBSD*)
        PLATFORM="freebsd"  # Unsupported
        cat /etc/freebsd-update.conf
        ;;
    Linux*)
        . /etc/os-release   # Load the variables
        PLATFORM=$ID # debian, ubuntu, raspbian, etc
        ;;
esac

# echo "Platform: $PLATFORM"
if [ "$PLATFORM" != "debian" ]; then
    echo "❌ Error: Only Debian Linux is supported." >&2
    exit 1
fi
