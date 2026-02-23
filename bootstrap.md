# Bootstrap

Bootstrap your developer workstation. This script provides a reproducible environment for the tech stack.

- **System Layer:** APT handles OS-level packages
- **Package Manager:** Homebrew manages the language stack and CLI tools

## How to Use

- `./bootstrap.sh`
- Restart your shell: Close and reopen the terminal.

This script is idempotent. You can run it again anytime.

## Quick-Start Editor

🐧 For quick file modifications, the [Nano](https://www.nano-editor.org/docs.php) is often bundled with your distribution.

## Software

To maintain workstation integrity, only install code from reputable & verified authors that regularly address issues with code updates.
The packages to be installed are listed in the `Brewfile` including Aider ✨

## Rust

[Rust](https://rust-lang.org/) is installed using [rustup](https://rustup.rs/).

## Java

[OpenJDK](https://openjdk.org/) [25](https://docs.oracle.com/en/java/javase/25/) is installed from [Microsoft's APT repository](https://learn.microsoft.com/en-us/linux/packages).
