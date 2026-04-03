# Fedora

Mission: We are in the process of testing all recipes on Fedora Atomic Desktop distro in the Universal Blue `ublue` project. The specific variant is called _Bluefin_ DX.

Scope:
- We aim to support all ublue variants, even those less specialized for developers, especially and including the most popular variant, _Bazzite_ -- which is focused on gamers. Gamers are power users. Note that gamer hardware is more likely in 2026 to have GPU's & VRAM (or unified memory architecture) that can be exploited for running local LLM's.

The specific hardware system+OS system for testing has these attributes:

    - VARIANT="Silverblue"
    - VARIANT_ID=bluefin-dx-nvidia-open
    - CPE_NAME="cpe:/o:universal-blue:bluefin:43"

Because the OS is immutable, and the `rpm-ostree` package management system is burdensome, the primary system for adding needed dev dependency packages is Homebrew.

TODO: Find Homebrew ways to backfill on the Bluefin OS system the same resources that are identified in the `./apt/apt.Packages` file. Add just recipes (categorized) for "brewing" the dependencies.

TODO: Test just recipes on ublue.

## Failed recipes

- install-jekyll
    - requires g++

## Debian specific recipes

Every recipe that relies on APT is of course Debian specific, including:

- check-apt
- configure-apt
- install-apt-packages
