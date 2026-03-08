# Baguette Box &nbsp; 🥖🥖🥖

sets up an AI-enabled developer environment on
[Debian](https://www.debian.org/)-based systems
([Ubuntu](https://docs.ubuntu.com/),
[Mint](https://linuxmint.com/),
[Pop!\_OS](https://system76.com/pop/),
[Raspberry Pi](https://www.raspberrypi.com/software/#raspberry-pi-os),
[ChromeOS](./docs/chromeos.md)
[Linux](https://www.linuxfoundation.org/))
with tooling for coding, cloud, compute, cache, storage, and data management.

<!-- --
- [Apple/Mac](https://www.apple.com/mac/) _future_
- [Microsoft/WSL2](https://learn.microsoft.com/en-us/windows/wsl/about) _future_
⏱🏎🏍
_From laptop purchase to vibe coding in an hour&hellip;_
<!-- -->

_This is beta quality code so backup before using, read the docs, and scan the source before running._

## Tech Stack

Languages

- [Java](./docs/java.md)
- [C#](https://learn.microsoft.com/en-us/dotnet/csharp) as [.NET SDK](https://dotnet.microsoft.com/)
- [Typescript](https://www.typescriptlang.org/docs/)/[JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript) via [Node](https://nodejs.org/)
- [Python](https://www.python.org/) via [UV](./docs/uv.md)
- [Go](https://go.dev/)
- [Rust](https://rust-lang.org/)

Agentic AI & pairing

- [Google Antigravity](https://antigravity.google/) AI IDE
- [Roo Code](https://roocode.com/) AI and [Gemini Code Assist](https://marketplace.visualstudio.com/items?itemName=Google.geminicodeassist) AI in [VS Code](https://code.visualstudio.com/) IDE
- [Goose](https://block.github.io/goose/docs/category/guides) AI CLI

CLI

- [Zsh](https://zsh.sourceforge.io/) & [pwsh](https://learn.microsoft.com/en-us/powershell/) shells
- [Oh My Posh](https://ohmyposh.dev/) prompt _with_ [nerd fonts](https://www.nerdfonts.com/font-downloads)
- [AWS](https://docs.aws.amazon.com/cli/), [Azure](https://learn.microsoft.com/en-us/powershell/azure/), [Google](https://cloud.google.com/cli), [kubectl](https://kubernetes.io/docs/reference/kubectl/) cloud tools
- [MinIO Client](https://github.com/minio/mc), [Rclone](.//rclone.md) storage utilities
- [Postgres](https://www.postgresql.org/docs/current/reference-client.html), [MySQL](https://mariadb.com/docs/server/clients-and-utilities/mariadb-client), [Redis](https://redis.io/docs/latest/develop/tools/), [SQLite](https://www.sqlite.org/) database clients

## Prepare

First, prepare your system

- On [ChromeOS](./docs/chromeos.md), set a password
  - `sudo passwd $USER`
- On Linux: Update, upgrade, and get git
  - `sudo apt update && sudo apt upgrade -y`
  - `sudo apt install git`
- For git, do your [First Time Setup](https://git-scm.com/book/ms/v2/Getting-Started-First-Time-Git-Setup) e.g.
  - `git config --global user.name "Jane Doe"`
  - `git config --global user.email "janedoe@example.com"`
- Clone this repo:
  - `git clone <repo-link>`
  - `cd <repo-name>`

## Proceed

Read the [`docs/README.md`](./docs/README.md) before you go for it&hellip;

- **Bootstrap:** Installs zsh, core language runtimes, and system-level fixes
  - Run `./box.sh bootstrap.yaml --install`
  - Restart your shell: `exit` and reopen the terminal tab.
- **Code:** Installs VS Code with some settings and extensions
  - Run `./box.sh code.yaml --install`

It gets the machine up & running in a couple of minutes.

<!-- --
Stay in touch to let us know about bugs & improvements.
<!-- -->

## Licensing Notice (Temporary - March 2026)

This repository is currently **source-available** but not formally licensed for redistribution or modification.

If you're interested in using, forking, adapting, or redistributing any part of this project (even non-commercially), please reach out to me first on Github or on [𝕏 (Twitter)](https://x.com/puresight).

I intend to choose a restrictive open-source license (likely GPL-3.0) in the coming months after gathering feedback and use cases. Direct conversation helps me understand needs and decide the best path.

Thank you for your interest!
