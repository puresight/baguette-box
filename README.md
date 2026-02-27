# Baguette Box

_This is beta quality code so backup before using, read the docs, and scan the source before running._

`baguette-box` 🥖
sets up an AI-enabled developer environment on
[Debian](https://www.debian.org/)-based systems
([Ubuntu](https://docs.ubuntu.com/),
[Mint](https://linuxmint.com/),
[Pop!\_OS](https://system76.com/pop/),
[Raspberry Pi](https://www.raspberrypi.com/software/#raspberry-pi-os),
[ChromeOS](https://chromeos.dev/en/linux)
[Linux](https://www.linuxfoundation.org/))
with tooling for cloud, compute, cache, storage, and data management.

<!-- --
- [Apple/Mac](https://www.apple.com/mac/) _future_
- [Microsoft/WSL2](https://learn.microsoft.com/en-us/windows/wsl/about) _future_
⏱🏎🏍
_From laptop purchase to vibe coding in an hour&hellip;_
<!-- -->

## Tech Stack

Languages

- [Java](https://dev.java/) as [OpenJDK](https://openjdk.org/)
- [C#](https://learn.microsoft.com/en-us/dotnet/csharp) as [.NET SDK](https://dotnet.microsoft.com/)
- [Typescript](https://www.typescriptlang.org/docs/)/[JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript) via [Node](https://nodejs.org/)
- [Python](https://www.python.org/) via [UV](https://docs.astral.sh/uv/getting-started/features/)
- [Go](https://go.dev/)
- [Rust](https://rust-lang.org/)

Agentic AI & pairing

- [Goose](https://block.github.io/goose/docs/category/guides) CLI
- [Roo Code](https://roocode.com/) in [VS Code](https://code.visualstudio.com/) 🖥

CLI

- [Zsh](https://zsh.sourceforge.io/) & [pwsh](https://learn.microsoft.com/en-us/powershell/) shells
- [Oh My Posh](https://ohmyposh.dev/) prompt _with_ [JetBrains Mono](https://www.jetbrains.com/lp/mono/) [nerd font](https://www.nerdfonts.com/font-downloads)
- [AWS](https://docs.aws.amazon.com/cli/), [Azure](https://learn.microsoft.com/en-us/powershell/azure/), [Google Cloud](https://cloud.google.com/cli) ☁ tools
- [kubectl](https://kubernetes.io/docs/reference/kubectl/) tool
- [Github](https://cli.github.com/) tools

DevOps

- [APT](https://wiki.debian.org/AptCLI) 🐧 Advanced Package Tool
- [Homebrew](http://docs.brew.sh/Homebrew-on-Linux) 🍺 Linuxbrew package manager
- [uv](https://docs.astral.sh/uv/getting-started/features/): Python's package manager
- [npm](https://www.npmjs.com/): Node's package manager
- [cargo](https://doc.rust-lang.org/cargo/): Rust's package manager

## Prepare

First, prepare your system

- ChromeOS: Set a password
  - `sudo passwd $USER`
- Linux: Update, upgrade, and install git
  - `sudo apt update && sudo apt upgrade -y`
  - `sudo apt install git`
- Git [First Time Setup](https://git-scm.com/book/ms/v2/Getting-Started-First-Time-Git-Setup) e.g.
  - `git config --global user.name "Jane Doe"`
  - `git config --global user.email "janedoe@example.com"`
- Clone the repo:
  - `git clone <repo-link>`
  - `cd <repo-name>`

## Proceed

Next, run the scripts, in sequence:

- **Bootstrap:** Installs zsh, core language runtimes, and system-level fixes
  - 📖 read [`bootstrap.md`](./bootstrap.md)
  - Run `./bootstrap.sh`
  - Restart your shell: `exit` and reopen the terminal tab.
- **IDE:** Installs VS Code with a curated suite of extensions
  - 📖 read [`ide.md`](./ide.md)
  - Run `./ide.sh`

The setup is simple to get you up & running. Stay in touch to let us know about bugs & improvements.

## Passkeys

[GNOME Keyring](https://wiki.gnome.org/Projects/GnomeKeyring) is a collection of components in the Linux environment that securely stores secrets, making them available to applications.
Since VS Code is going to use this system anyway, you might as well use it, too. Secrets include credentials for apps, virtual private networks, shared drives, databases, signed messaging, secure tunnels, SSL/TLS certificates, etc. How to:

<!-- --
It was designed to run as a daemon, automatically unlocking stored secrets when a user logs into their session.
<!-- -->

- **View:** [`seahorse` aka "Passwords and Keys"](https://wiki.gnome.org/Apps/Seahorse) is a graphical frontend for the GNOME Keyring system; helpful for inspection or verification
- **Store:** `echo -n "YOUR_ACTUAL_API_KEY" | secret-tool store --label="Gemini API Unbilled Key" service google-ai account unbilled-gemini-key`
- **Retrieve:** `export GEMINI_API_KEY=$(secret-tool lookup service google-ai account unbilled-gemini-key)`
