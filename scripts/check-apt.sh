#!/bin/bash

# Function
check_apt() {
    if ! command -v apt &> /dev/null; then
        printf "❌ Error: APT not found; this recipe was designed for Debian-based systems.\n" >&2
        exit 1
    fi
}

check_apt
