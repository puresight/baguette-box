# Plan

This plan folder contains the specs & plans for this repository. Baguette Box ("box") is full automation for setting up (and maintaining) a new dev workstation. See also `./README.md` and `./docs/README.md`.

## Values & Approach

- "Cattle not pets" approach
- Aiming towards stateless workstations
- provide most of what a Cloud native, AI augmented, polyglot developer will need or want on the job
- facilitate last mile customization with ./docs/ markdown guidance
- Idempotent
- Extensibile
- Configurable
- Reasonably Secure

## Specs

- Shells
  - bash is the primary shell language
  - pwsh is only used for powershell specific things
  - zsh is the user's default shell
- Linux OS
  - Debian Linux is the primary support target
  - Crostini is the primary operating environment
  - Future consideration: Cross-platform Linux support is planned
    - starting with Debian distros
    - macOS support
    - ending with Fedora atomic stateless distros
  - Baseline release: Debian 12 "bookworm" distro, in Crostini
- Crostini
  - avoid virtualization & containers
  - avoid compiling source code, for updates or installations
- Configurable
  - YAML is the primary syntax for configuration
    - Example: `./system.yaml`
    - Tasks are functions sourced into box.sh from the ./lib directory, chiefly from bootstrap.sh or code.sh

### Flow of control

- `box.sh` is the only entry point; it is configured with yaml files; the only mode it currently supports is install.
- `lib` directory has the library of supporting code
  - lib/bootstrap.sh has most functions for the system install tasks
  - lib/code.sh has functions for the VS code install tasks

## Monty's Repo Roadmap Items

- ! Add CLI tools: fzf, zoxide using Eget
- ngrok or alternative for exposing local ports on Internet
- meh: add help: [tldr](https://github.com/tldr-pages/tldr) & [navi](https://github.com/denisidoro/navi)
- Modes: dry-run, install, update, upgrade, ?etc
- Update mode: plan and implement
- cross-platform
  - architecture improvement for cross-platform
  - Pop!\_OS support
  - MacOS support
  - Fedora atomic linux support
- Security hardening

## Monty's research queue

- Tailscale.com
- Neon.com
- Chezmoi for dotfiles
