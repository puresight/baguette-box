# ublue support

Mission: We are in the process of testing all recipes on Fedora Atomic Desktop distro in the Universal Blue `ublue` project. The specific variant is called _Bluefin_ DX.

Scope: We aim to support all [ublue](https://universal-blue.org/) variants, even those less specialized for developers, especially and including the most popular variant, _Bazzite_ -- which is focused on gamers. Gamers are power users. Note that gamer hardware is more likely in 2026 to have GPU's & VRAM (or unified memory architecture) that can be exploited for running local LLM's.

Test equipment: The specific hardware `/etc/os-release` for testing has these attributes:

```sh
- VARIANT="Silverblue"
- VARIANT_ID=bluefin-dx-nvidia-open
- CPE_NAME="cpe:/o:universal-blue:bluefin:43"
```

Because the OS is immutable, and the `rpm-ostree` package management system is burdensome, ublue's primary system for adding needed dev dependency packages is Homebrew.

TODO: Test just recipes on ublue.

## Failed recipes

- install-jekyll
    - requires g++

## Unneeded recipes

Some packages are high level supported by the Bluefin-DX already:

- install-llmfit
- install-gemini (CLI)
- install-kubectl
- install-goose
- install-ollama
- install-tools-terminal
- install-font
- configure-shell

## Debian specific recipes

Every recipe that relies on APT is of course Debian specific, including:

- check-apt
- configure-apt
- install-apt-packages
