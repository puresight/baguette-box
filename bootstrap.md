# Bootstrap

Bootstrap your developer workstation. This script provides a reproducible environment for the tech stack.

- APT handles OS-level packages
- Homebrew is used for **some** the language stack and CLI tools but not these:
  - [AWS](https://docs.aws.amazon.com/cli/) tools
  - [Github](https://cli.github.com/) tools

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
The _cargo binstall_ tool is added for quick package installation because the standard _cargo install_ command downloads source code and compiles it on your machine, which can be slow. To bypass this and install pre-compiled binaries, use the community-standard tools like [cargo-binstall](https://github.com/cargo-bins/cargo-binstall). This is the most popular method. it automatically searches for pre-compiled releases on GitHub or other registries.
Usage: Replace `cargo install <package>` with `cargo binstall <package>`

- 📖 [2024/11 Ben Brandt: A Better Cargo Install Workflow: How I manage to keep the tools I've installed with cargo up-to-date](https://benjaminbrandt.com/a-better-cargo-install-workflow/)
- 📖 [2025/12 Sam Schlinkert: A curated list of command-line utilities written in Rust](https://github.com/sts10/rust-command-line-utilities)

## Java

[OpenJDK](https://openjdk.org/) [21](https://docs.oracle.com/en/java/javase/21/) is installed from [Microsoft's APT repository](https://learn.microsoft.com/en-us/linux/packages).

How to cope with multiple versions? Learn about `update-alternatives`

- 📖 [2024/7 Baeldung: The `update-alternatives` Command in Linux](https://www.baeldung.com/linux/update-alternatives-command)

## .NET

[Microsoft .NET](https://dotnet.microsoft.com/) [SDK 10](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/overview) and [Powershell](https://learn.microsoft.com/en-us/powershell/) (`pwsh`) are installed from Microsoft's APT repository.
