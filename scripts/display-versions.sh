#!/bin/bash
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------
#
#   Function to display current versions
#
# ------ # ------ # ------ # ------ # ------ # ------ # ------ # ------

# Source lib scripts
SCRIPTROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && cd .. && pwd)"
. "$SCRIPTROOT/scripts/lib/platforms.sh"

display_versions() {
    # -- Shells --
    # bash --version
    # zsh --version
    if command -v pwsh &>/dev/null; then printf "$(which pwsh) $(pwsh --version)\n"; fi

    # -- Tools --
    # mise --version
    if command -v gcloud &> /dev/null; then printf "$(which gcloud) $(gcloud --version | head -n 1)\n"; fi # FIXME too verbose: we just want the main gcloud version
    if command -v aws &>/dev/null; then printf "$(which aws) $(aws --version)\n"; fi
    if command -v gh &> /dev/null; then printf "$(which gh) $(gh --version | head -n 1)\n"; fi # FIXME too verbose: just the GH version please
    # if command -v mc &> /dev/null; then printf "$(which mc) $(mc --version | head -n 1)\n"; fi # FIXME too verbose: just the GH version please

    # -- Languages --
    if command -v uv &>/dev/null; then printf "$(which uv) $(uv --version)\n"; fi
    if command -v python3 &>/dev/null; then printf "$(which python3) $(python3 --version)\n"; fi
    if command -v just &>/dev/null; then printf "$(which just) $(just --version)\n"; fi
    if command -v rustc &>/dev/null; then printf "$(which rustc) $(rustc --version) "; fi
    if command -v cargo &>/dev/null; then printf "$(cargo --version) "; fi
    if command -v cargo &>/dev/null; then printf "cargo-binstall $(cargo binstall -V --no-confirm --disable-telemetry)\n"; fi
    if command -v go &>/dev/null; then printf "$(which go) $(go version)\n"; fi
    if command -v ruby &>/dev/null; then printf "$(which ruby) $(ruby --version)\n"; fi
    if command -v javac &>/dev/null; then printf "$(which javac) $(javac -version 2>&1)\n"; fi
    # if command -v scala &>/dev/null; then printf "$(which scala) $(scala -version 2>&1)\n"; fi
    if command -v kotlinc &>/dev/null; then printf "$(which kotlinc) $(kotlinc -version 2>&1)\n"; fi
    if command -v dotnet &>/dev/null; then printf "$(which dotnet) $(dotnet --version)\n"; fi
    if command -v kubectl &>/dev/null; then printf "$(which kubectl) $(kubectl version --client)\n"; fi

    # -- Frontend --
    # if command -v vp &>/dev/null; then printf "$(which vp) $(vp --version)\n"; fi
    if command -v node &>/dev/null; then printf "$(which node) $(node -v)\n"; fi
    if command -v npm &>/dev/null; then printf "$(which npm) $(npm -v)\n"; fi
}

# This script can be run independently.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    display_versions "$@"
fi
