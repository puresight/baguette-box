# Bootstrap

Bootstrap your workstation. This script provides a reproducible environment for the tech stack.

_To maintain workstation integrity, only install code from reputable & verified authors that regularly address issues with code updates._

## How to Use

- `./bootstrap.sh`
- Restart your shell: Close and reopen the terminal.

This script is idempotent. You can run it again anytime.

## System Architecture

**[APT](https://wiki.debian.org/AptCLI)** installs packages in `Aptfile` including

- [Zsh](https://zsh.sourceforge.io/) shell
- [AWS CLI](https://docs.aws.amazon.com/cli/) tools
- †[Microsoft .NET](https://dotnet.microsoft.com/) [SDK 10](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/overview) framework
- †[Powershell](https://learn.microsoft.com/en-us/powershell/) shell

†These packages are _added to_ what's in the Aptfile.

**[Homebrew](http://docs.brew.sh/Homebrew-on-Linux)** 🍺 is used for some things; see the `Brewfile` for the packages it installs

- [Go](https://go.dev/)
- [Node](https://nodejs.org/)
- [Github](https://cli.github.com/) tools
- [Aider](https://aider.chat/) ✨ CLI

_These have a custom setup:_

- [uv](https://docs.astral.sh/uv/getting-started/features/) and [Python](https://www.python.org/)
- [Oh My Posh](https://ohmyposh.dev/) prompt
- [Goose](https://block.github.io/goose/docs/category/guides) ✨ CLI

_These are planned for future integration:_

- **[Mise](https://mise.jdx.dev/)** is a tool with potential to manage installations of languages and tools for development. It could be used to manage multiple versions of Node.js, Go, or Ruby on the same machine.

## Rust language

[Rust](https://rust-lang.org/) is installed using [rustup](https://rustup.rs/).
The _cargo binstall_ tool is added for quick package installation because the standard _cargo install_ command downloads source code and compiles it on your machine, which can be slow. To bypass this and install pre-compiled binaries, use the community-standard tools like [cargo-binstall](https://github.com/cargo-bins/cargo-binstall). This is the most popular method. it automatically searches for pre-compiled releases on GitHub or other registries.
Usage: Replace `cargo install <package>` with `cargo binstall <package>`

- 📖 [2024/11 Ben Brandt: A Better Cargo Install Workflow: How I manage to keep the tools I've installed with cargo up-to-date](https://benjaminbrandt.com/a-better-cargo-install-workflow/)
- 📖 [2025/12 Sam Schlinkert: A curated list of command-line utilities written in Rust](https://github.com/sts10/rust-command-line-utilities)

## Java language

[OpenJDK](https://openjdk.org/) [21](https://docs.oracle.com/en/java/javase/21/) is installed from [Microsoft's APT repository](https://learn.microsoft.com/en-us/linux/packages).
How to cope with multiple versions? Learn about `update-alternatives`

- 📖 [2024/7 Baeldung: The `update-alternatives` Command in Linux](https://www.baeldung.com/linux/update-alternatives-command)
