# IDE Setup

This module installs Microsoft **VS Code** and a curated suite of verified extensions.

## Installation

1. Ensure the base `bootstrap.sh` has been executed.
1. Run `./ide.sh`.

## Security & Maintenance

### Verified Extensions

To maintain workstation integrity, the `ide.sh` script only installs extensions from verified, reputable publishers. 

### AI Extensions

The following extensions are highly useful for AI-driven development but are not installed automatically. Review their permissions before manual installation:

- Roo Code (`rooveterinaryinc.roo-cline`): Required for autonomous coding tasks.
- Aider (extension-specific alternatives): If using VS Code wrappers for Aider.

### Upkeep

- on Linux: VS Code is integrated into the system package manager via the Microsoft repository. Run `sudo apt upgrade` to update.
- on Mac: VS Code manages its own updates via the Microsoft Update service.

## Cross-Platform Support

This is evolving.
The `ide.sh` script detects if it is running on **Darwin (macOS)** or **Linux** and adjusts the installation method accordingly (Brew Cask vs. Apt).
