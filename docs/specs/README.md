# Specs

This `doc/specs` folder contains the specs & plans for this repository. Baguette Box ("box") is full automation for setting up (and maintaining) a new dev workstation. See also its `./README.md` and `../README.md`.

## Values & Approach

- "Cattle not pets" approach
- Aiming towards stateless workstations
- provide most of what a Cloud native, AI augmented, polyglot developer will need or want on the job
- facilitate last mile customization with ./docs/ markdown guidance
- Reproducible (no snowflakes)
- Idempotent
- Extensibile
- Configurable
- Reasonably Secure

## Project Direction

- Shells
  - bash is the primary shell language
  - pwsh is only used for powershell specific things
  - zsh is the user's default shell
- Linux OS
  - Debian Linux is the primary support target
  - Crostini is the primary operating environment
  - Baseline release: Debian 12 "bookworm" distro, in Crostini
  - Future consideration: Cross-platform Linux support is planned
    - starting with Debian distros
    - macOS support
    - ending with Fedora atomic stateless distros
- Crostini
  - strongly avoid virtualization & containers
  - avoid compiling source code, for updates or installations
- Configuration (legacy way)
  - YAML is the primary syntax for configuration
    - Example: `./bootstrap.yaml`
    - Tasks are functions sourced into box.sh from the ./scripts directory, chiefly from index.sh
- Configuration (new way)
  - in `justfile`

### Flow of control

- Legacy way: `box.sh` is the only entry point; it is configured with yaml files; the only mode it currently supports is install.
- New way: Using just and `justfile` is the entry point
- The `scripts` directory has the code
  - `scripts/index.sh` has public functions for the exposed recipes/tasks
