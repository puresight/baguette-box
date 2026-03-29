# Baguette Box &nbsp; 🥖🥖🥖

sets up an AI-enabled developer environment on
Debian-based,
[ChromeOS](./docs/chromeos.md)
Linux
systems
with tooling for coding, cloud, compute, cache, storage, and data management.
Here you will find tools to do software development, whether you build for [Web](./docs/dev-web.md), for [Mobile](./docs/dev-mobile.md), for [Desktop](./docs/dev-desktop.md), or the [Cloud](./docs/dev-cloud.md).

<!-- --
[Ubuntu](https://docs.ubuntu.com/),
[Mint](https://linuxmint.com/),
[Pop!\_OS](https://system76.com/pop/),
[Raspberry Pi](https://www.raspberrypi.com/software/#raspberry-pi-os)
[Apple/Mac](https://www.apple.com/mac/) _future_
[Microsoft/WSL2](https://learn.microsoft.com/en-us/windows/wsl/about) _future_
<!-- -->

## Tech Stack

#### Languages

- [Python via uv](./docs/uv.md)
- [Typescript](./docs/typescript.md), [AssemblyScript](./docs/assemblyscript.md), & [JavaScript via Node](./docs/node.md)
- [Java](./docs/java.md), [Kotlin](./docs/kotlin.md), & [Scala](./docs/scala.md)
- [C# via .NET](./dotnet/README.md)
- [Ruby on Rails](./docs/ruby.md)
- [Erlang](./docs/erlang.md) & [Elixir](./docs/elixir.md)
- [Haskell](./docs/haskell.md)
- [Dart (Flutter)](./docs/flutter.md) 
- [WebAssembly](./docs/wasm.md)
- [Rust](./docs/rust.md)
- [Go](./docs/go.md)

#### Agentic AI & pairing

- [Google Antigravity](https://antigravity.google/docs/home) IDE
- _Gemini Code Assist_ and _Roo Code_ in [VS Code](./code/README.md) IDE
- _Gemini CLI_ via [npm](./docs/node.md)
- [Goose](https://block.github.io/goose/docs/category/guides) CLI
- [Aider](./docs/aider.md) CLI via [Homebrew](./homebrew/README.md)
- [Ollama](./docs/ollama.md)

#### CLI

- [Zsh](https://zsh.sourceforge.io/) & [pwsh](https://learn.microsoft.com/en-us/powershell/) shells
- [Oh My Posh](https://ohmyposh.dev/) prompt _with_ [nerd fonts](./docs/fonts.md)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/), [AWS](https://docs.aws.amazon.com/cli/), [Azure](https://learn.microsoft.com/en-us/powershell/azure/), [Google Cloud](https://cloud.google.com/cli) tools
- [MinIO Client](./docs/mc.md), [Rclone](./docs/rclone.md) storage utilities
- [Postgres](https://www.postgresql.org/docs/), [MariaDB](https://mariadb.com/docs/server/clients-and-utilities/mariadb-client/mariadb-command-line-client), [Redis](https://redis.io/docs/latest/develop/tools/), [SQLite](https://www.sqlite.org/) [database](./docs/databases.md) clients

## Prepare

Next, prepare your new system:

- On Linux, upgrade and install git
  ```sh
  sudo apt update && sudo apt upgrade -y
  sudo apt install git
  ```
- On [ChromeOS](./docs/chromeos.md), set a user password
  ```sh
  sudo passwd $USER
  ```
- Do your [Git First Time Setup](https://git-scm.com/book/ms/v2/Getting-Started-First-Time-Git-Setup) e.g.
  ```sh
  git config --global user.name "Jane Doe"
  git config --global user.email "janedoe@example.com"
  ```
- [Install Just](https://just.systems/man/en/installation.html) e.g.
  ```sh
  export PATH="$PATH:$HOME/.local/bin"
  curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin
  just --version
  ```
- [Clone this repo](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
  ```sh
  cd ~/src
  git clone https://github.com/puresight/baguette-box.git
  cd baguette-box
  ```
  
## Proceed

Finally, proceed to set up your environment.

- ↪️ View the menu by typing: `just`
- ↪️ Run recipe to bootstrap your new system: `just bootstrap`
- ↪️ Run recipe to install VS Code: `just code`

Your system configuration will be ready in a few minutes.

<!-- --
Stay in touch to let us know about bugs & improvements.
<!-- -->

## Plan

Finally, after you bootstrap and have Code ready, consider your plans for the workstation. What tools do you need to accomplish your aims? You could write them down in a markdown file, and compare your goals with the project’s [justfile](./justfile), to see what recipes are recommended.
_A just-in-time approach to tool installation is recommended.
You can always add more later._

## Licensing Notice (Temporary - March 2026)

This repository is currently **source-available** but not formally licensed for redistribution or modification.

If you're interested in using, forking, adapting, or redistributing any part of this project (even non-commercially), please reach out to me first on [𝕏 (Twitter)](https://x.com/puresight).

I intend to choose a restrictive open-source license (likely GPL-3.0) in the coming months after gathering feedback and use cases. Direct conversation helps me understand needs and decide the best path.

Thank you for your interest.
