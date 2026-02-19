# IDE

IDE setup installs Microsoft **VS Code** and some extensions.

The cross-platform support is nascent; the `ide.sh` script tries to detect if it is running on Darwin (macOS) or Linux and adjusts the installation method accordingly (Brew Cask vs. Apt).

- on Linux: VS Code is integrated into the system package manager via the Microsoft repository?
- on Mac: VS Code manages its own updates via the Microsoft Update service.

## VS Code Extensions

Before you run the script, inspect the extensions that it will install. To maintain workstation integrity, only install extensions from verified authors that regularly address issues with updates.

## How to Use

1. Ensure the base `bootstrap.sh` has already been executed
1. Run `./ide.sh`
