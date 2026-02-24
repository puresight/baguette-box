#!/bin/bash

OS_TYPE=$(uname -s)
PLATFORM="unknown"
if [ "$OS_TYPE" == "Darwin" ]; then
    PLATFORM="macos"
elif [ "$OS_TYPE" == "Linux" ]; then
    PLATFORM="linux"
fi

if [ "$PLATFORM" == "unknown" ]; then
    echo "ERROR: Unsupported platform ($OS_TYPE / $PLATFORM). Only Linux (Crostini/Debian) and MacOS are supported." >&2
    exit 1
fi
