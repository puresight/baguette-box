# IDE

This IDE setup `ide.sh` script installs and configures Microsoft **VS Code** and some extensions.

## Extensions

To maintain workstation integrity, only install extensions from reputable & verified authors that regularly address issues with code updates.
The extensions to be installed are listed in the `vscodeExtensions` file, including
[Roo Code](https://marketplace.visualstudio.com/items?itemName=RooVeterinaryInc.roo-cline) ✨

## Configuration

The script updates your `argv.json` and `settings.json`.
Unfortunately (as a consequence) it disintegrates the comments that were in them. The JSON updates come from the files in `vscode-updates` directory.

## How to Use

1. Ensure the base `bootstrap.sh` has already been executed
1. Run `./ide.sh`

This script is idempotent. You can run it again anytime.
