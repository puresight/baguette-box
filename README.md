# Baguette Box

`baguette-box` 🥖 helps rapidly set up a new developer workstation. It is a reproducible system for starting up an AI-augmented development environment instance.

Note: This is beta quality code so backup before using, read the docs, and scan the source before running.

- [Google/ChromeOS](https://chromeos.dev/en/linux) 🐧 primary
- [Debian Linux](https://www.debian.org/) 🐧 secondary
- [Apple/Mac](https://www.apple.com/mac/) future
- [Microsoft/WSL2](https://learn.microsoft.com/en-us/windows/wsl/about) future

## Tech Stack

CLI

- [Zsh](https://zsh.sourceforge.io/) shell
- [Powershell](https://learn.microsoft.com/en-us/powershell/) shell
- [Oh My Posh](https://ohmyposh.dev/) prompt
- [Github CLI](https://cli.github.com/) tools

Languages

- [Java](https://dev.java/) ☕ as [OpenJDK](https://openjdk.org/)
- [C#](https://learn.microsoft.com/en-us/dotnet/csha) as [.NET SDK](https://dotnet.microsoft.com/)
- [Python](https://www.python.org/) 🐍 via [uv](https://docs.astral.sh/uv/getting-started/features/)
- [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) via [Node](https://nodejs.org/)
- [Go](https://go.dev/)
- [Rust](https://rust-lang.org/)

AI pairing

- [Aider](https://aider.chat/) (CLI)
- [Roo Code](https://roocode.com/) (in [VS Code](https://code.visualstudio.com/))

DevOps

- [APT](https://wiki.debian.org/AptCLI) 🐧 Advanced Package Tool is a command-line utility used in Debian-based Linux systems (Ubuntu, Mint) to manage software packages. It automates installing, upgrading, and removing software, including handling dependencies by accessing repositories defined in `/etc/apt/sources.list`
- [Homebrew](http://docs.brew.sh/Homebrew-on-Linux) 🍺 Linuxbrew package manager
- [uv](https://docs.astral.sh/uv/getting-started/features/): Python's package manager
- [npm](https://www.npmjs.com/): Node's package manager
- [cargo](https://doc.rust-lang.org/cargo/): Rust's package manager

## Prepare

First, prepare your system

- ChromeOS: Set a password
  - `sudo passwd $USER`
- Linux: Update your packages and install Git
  - `sudo apt update && sudo apt install git -y`
- Git [First Time Setup](https://git-scm.com/book/ms/v2/Getting-Started-First-Time-Git-Setup) e.g.
  - `git config --global user.name "Jane Doe"`
  - `git config --global user.email "janedoe@example.com"`
- Clone the repo:
  - `git clone <repo-link>`
  - `cd <repo-name>`

## Scripts

Next, run the code

1. **bootstrap:** Installs zsh, core language runtimes, and system-level fixes; read `bootstrap.md`
1. **ide:** Installs VS Code with a curated suite of extensions; read `ide.md`

## Secrets

🐧 Secrets include credentials (access tokens, API keys, username/password, etc) for applications, databases, websites, network logins, etc. VS Code is going to use this system anyway, so you might as well too.

- **View:** [`seahorse` aka "Passwords and Keys"](https://wiki.gnome.org/Apps/Seahorse) is a graphical frontend for the GNOME Keyring system; helpful for inspection or verification
- **Store:** `echo -n "YOUR_ACTUAL_API_KEY" | secret-tool store --label="Gemini API Unbilled Key" service google-ai account unbilled-gemini-key`
- **Retrieve:** `export GEMINI_API_KEY=$(secret-tool lookup service google-ai account unbilled-gemini-key)`
