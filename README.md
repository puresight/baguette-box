# Baguette Box &nbsp; 🥖🥖🥖

sets up an AI-enabled developer environment on
Debian-based,
[ChromeOS](./docs/chromeos.md)
Linux
systems
with tooling for coding, cloud, compute, cache, storage, and data management.

<!-- --
[Ubuntu](https://docs.ubuntu.com/),
[Mint](https://linuxmint.com/),
[Pop!\_OS](https://system76.com/pop/),
[Raspberry Pi](https://www.raspberrypi.com/software/#raspberry-pi-os)
[Apple/Mac](https://www.apple.com/mac/) _future_
[Microsoft/WSL2](https://learn.microsoft.com/en-us/windows/wsl/about) _future_
<!-- -->

## Tech Stack

Languages

- [Java](./docs/java.md)
- [C# .NET](./docs/dotnet.md)
- [Ruby on Rails](./docs/ruby.md)
- [Typescript/JS via Node](./docs/node.md)
- [Python via UV](./docs/uv.md)
- [Go](./docs/go.md)
- [Rust](./docs/rust.md)

Agentic AI & pairing

- [Google Antigravity](https://antigravity.google/) AI IDE
- [Gemini Code Assist](https://marketplace.visualstudio.com/items?itemName=Google.geminicodeassist) AI and [Roo Code](https://roocode.com/) AI in [VS Code](./code/README.md) IDE
- [Goose](https://block.github.io/goose/docs/category/guides) AI CLI

CLI

- [Zsh](https://zsh.sourceforge.io/) & [pwsh](https://learn.microsoft.com/en-us/powershell/) shells
- [Oh My Posh](https://ohmyposh.dev/) prompt _with_ [nerd fonts](https://www.nerdfonts.com/font-downloads)
- [AWS](https://docs.aws.amazon.com/cli/), [Azure](https://learn.microsoft.com/en-us/powershell/azure/), [Google](https://cloud.google.com/cli), [kubectl](https://kubernetes.io/docs/reference/kubectl/) cloud tools
- [MinIO Client](./docs/mc.md), [Rclone](./docs/rclone.md) storage utils
- [Postgres](https://www.postgresql.org/docs/current/reference-client.html), [MariaDB](https://mariadb.com/docs/server/clients-and-utilities/mariadb-client/mariadb-command-line-client), [Redis](https://redis.io/docs/latest/develop/tools/), [SQLite](https://www.sqlite.org/) database clients

## Plan

Take a minute to think about your intention.
Write a quick markdown file about your needs and purposes for the workstation, and the tools that will help you accomplish that.
This page will be useful to you and your AI agents.

Note: You have powerful tools to help you. It is best to not frontload more software than you need. You can always add more later, when your plan matures, or changes.

## Prepare

Next, prepare your new system

- On Linux: Update, upgrade, and get git
  - `sudo apt update && sudo apt upgrade -y`
  - `sudo apt install git`
- On [ChromeOS](./docs/chromeos.md), set a password
  - `sudo passwd $USER`
- For git, do your [First Time Setup](https://git-scm.com/book/ms/v2/Getting-Started-First-Time-Git-Setup) e.g.
  - `git config --global user.name "Jane Doe"`
  - `git config --global user.email "janedoe@example.com"`
- Clone this repo:
  - `git clone <repo-link>`
  - `cd <repo-name>`

## Proceed

Finally, browse the [`docs/README.md`](./docs/README.md) and&hellip;

1. **For IT professionals using Ansible:** (Optional) Install the latest uv, python, & ansible  
   Run `./box.sh ansible.yaml --install`  

1. **Bootstrap your system:** Install your shell, core language runtimes, system-level fixes, etc  
   Run `./box.sh system.yaml --install`  

1. **Code:** Install [VS Code](./code/README.md) with settings and extensions  
   Run `./box.sh code.yaml --install`

The workstation will be ready in a minute.

<!-- --
Stay in touch to let us know about bugs & improvements.
<!-- -->

## Licensing Notice (Temporary - March 2026)

This repository is currently **source-available** but not formally licensed for redistribution or modification.

If you're interested in using, forking, adapting, or redistributing any part of this project (even non-commercially), please reach out to me first on [𝕏 (Twitter)](https://x.com/puresight).

I intend to choose a restrictive open-source license (likely GPL-3.0) in the coming months after gathering feedback and use cases. Direct conversation helps me understand needs and decide the best path.

Thank you for your interest!
