# Bootstrap

Bootstrap your workstation. This script provides a reproducible environment for the tech stack.

_To maintain workstation integrity, only install code from reputable & verified authors that regularly address issues with code updates._

## How to Use

- `./bootstrap.sh`
- Restart your shell: Close and reopen the terminal.

This script is idempotent. You can run it again anytime.

## System Architecture

### APT

Bootstrap connects [APT](https://wiki.debian.org/AptCLI) to these repository [sources](https://wiki.debian.org/SourcesList) &mdash;

- [Google Cloud CLI](https://docs.cloud.google.com/sdk/docs/install-sdk#deb) `google-cloud` <packages.cloud.google.com/apt>
- [Microsoft prod](https://learn.microsoft.com/en-us/linux/packages) `microsoft-prod` <packages.microsoft.com/debian/12/prod>
- [Azure Cloud CLI](https://learn.microsoft.com/en-us/cli/azure/) `azure-cli` <packages.microsoft.com/repos/azure-cli/>
- [VS Code](https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions) `vscode` <packages.microsoft.com/repos/code>

Bootstrap uses APT to install packages in the [`Aptfile`](./Aptfile) like

- [Zsh](https://zsh.sourceforge.io/) shell
- [kubectl](https://kubernetes.io/docs/reference/kubectl/) tool
- [gcloud CLI](https://cloud.google.com/cli) tools
- [aws CLI](https://docs.aws.amazon.com/cli/) tools
- †[.NET](https://dotnet.microsoft.com/) [SDK 10](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-10/overview) framework
- †[Powershell](https://learn.microsoft.com/en-us/powershell/) shell
- †Java [OpenJDK](https://openjdk.org/) [21](https://docs.oracle.com/en/java/javase/21/)
  - How to manage with multiple versions? Learn about `update-alternatives`
    - 📖 [2024/7 Baeldung: The `update-alternatives` Command in Linux](https://www.baeldung.com/linux/update-alternatives-command)

†These packages are _added to_ what's already in the [Aptfile](./Aptfile).

### Homebrew

Bootstrap uses [Homebrew](http://docs.brew.sh/Homebrew-on-Linux) 🍺 to install packages in the [`Brewfile`](./Brewfile) like

- [Go](https://go.dev/) language
- [Node](https://nodejs.org/) engine
- [Github](https://cli.github.com/) tools
- [Aider](https://aider.chat/) ✨ CLI

### UV

[UV](https://docs.astral.sh/uv/getting-started/features/), the unified tool that replaces utilities in the Python ecosystem (pip, pip-tools, pyenv, virtualenv, pipx, poetry, twine), installs

- [Python](https://www.python.org/)

### Independent

Bootstrap sets these up &mdash;

- [Oh My Posh](https://ohmyposh.dev/) prompt (self-updating)
- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) glyph support (non-updating)
- [Goose](https://block.github.io/goose/docs/category/guides) ✨ CLI (relies on bootstrap)
- [Rust](https://rust-lang.org/) is installed using [rustup](https://rustup.rs/) (self-updating)
  - [cargo-binstall](https://github.com/cargo-bins/cargo-binstall) tool is added for quick package installation because the standard _cargo install_ command downloads source code and compiles it on your machine, which can be slow. To bypass this and install pre-compiled binaries, use the community-standard tools like cargo-binstall. This is the most popular method. it automatically searches for pre-compiled releases on GitHub or other registries.
    Usage: Replace `cargo install <package>` with `cargo binstall <package>`
    - 📖 [2024/11 Ben Brandt: A Better Cargo Install Workflow: How I manage to keep the tools I've installed with cargo up-to-date](https://benjaminbrandt.com/a-better-cargo-install-workflow/)
    - 📖 [2025/12 Sam Schlinkert: A curated list of command-line utilities written in Rust](https://github.com/sts10/rust-command-line-utilities)

### Mise en place

**[Mise](https://mise.jdx.dev/)** is a tool with potential to manage installations of languages and tools for development. It could be used to manage multiple versions of Node.js, Go, or Ruby in the future. Under construction.
