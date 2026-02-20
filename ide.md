# IDE

This IDE setup `ide.sh` script installs and configures Microsoft **VS Code** and some extensions.

🌱 The cross-platform support is nascent; the script tries to detect if it is running on Darwin (macOS) or (Debian) Linux and adjusts the installation method accordingly.

## Extensions

The extensions to be installed are listed in the `CodeExtensions` file. To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates.

## Configuration

The script uses updates your `argv.json` and `settings.json` without overwriting your existing configurations although any/all JSON comments shall be removed.

## How to Use

1. Ensure the base `bootstrap.sh` has already been executed
1. Run `./ide.sh`
