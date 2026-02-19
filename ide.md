# IDE

This IDE setup `ide.sh` script installs Microsoft **VS Code** and some extensions.

The cross-platform support is nascent; the script tries to detect if it is running on Darwin (macOS) or Linux and adjusts the installation method accordingly (Brew Cask vs. Apt).

- on Linux 🐧 VS Code is integrated into the system package manager via the Microsoft repository
- on Mac: VS Code manages its own updates via the Microsoft Update service.

## Extensions

The extensions to be installed are listed in the `CodeExtensions` file. To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates.

## Configuration

The script uses updates your `argv.json` and `settings.json` without overwriting your existing configurations.

## How to Use

1. Ensure the base `bootstrap.sh` has already been executed
1. Run `./ide.sh`
