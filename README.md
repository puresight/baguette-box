# Baguette Box

`baguette-box` 🥖 helps rapidly set up a new developer workstation. It is a reproducible system for starting up an AI-augmented development environment instance.

- [Google/ChromeOS](https://www.chromium.org/chromium-os/developer-library/guides/containers/containers-and-vms/) 🐧 primary
- [GNU/Linux](https://www.linuxfoundation.org/) 🐧 secondary
- [Apple/Mac](https://www.apple.com/mac/) 🐧 future
- [Microsoft/WSL2](https://learn.microsoft.com/en-us/windows/wsl/about) 🐧 future

## Tech Stack

CLI

- [Zsh](https://zsh.sourceforge.io/) shell and [Starship](https://starship.rs/) prompt
- [Github CLI](https://cli.github.com/)

Languages

- [Python](https://www.python.org/) via ([uv](https://docs.astral.sh/uv/getting-started/features/))
- [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) via ([Node](https://nodejs.org/))
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

- [ChromeOS](https://www.chromium.org/chromium-os/developer-library/guides/containers/containers-and-vms/) 🐧 you must have a password: `sudo passwd $USER`
- Linux 🐧 `sudo apt update && sudo apt install git -y`
- [Git First Time Setup](https://git-scm.com/book/ms/v2/Getting-Started-First-Time-Git-Setup)
- SSH: Ensure your SSH keys are generated and added to your version control provider
  - [Github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- Clone the repo:
  - `git clone <repo-link>`
  - `cd <repo-name>`

## Scripts

Next, run the code

1. **bootstrap:** Installs zsh with starship, core language runtimes, and system-level fixes; read `bootstrap.md`
1. **ide:** Installs VS Code with a curated suite of extensions; read `ide.md`
