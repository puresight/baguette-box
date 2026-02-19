# baguette-box

This software helps you rapidly set up a new developer workstation. It is a reproducible system for starting up an AI-augmented development environment instance. Originally designed for high-performance Chromebooks (Crostini), it's evolving towards being cross-platform ([Linux](https://www.linuxfoundation.org/) / [Mac](https://www.apple.com/mac/) / [Chromebook](https://www.chromium.org/chromium-os/developer-library/guides/containers/containers-and-vms/) / [WSL2](https://learn.microsoft.com/en-us/windows/wsl/about)).

## Tech stack

Languages

- [Python](https://www.python.org/) ([uv](https://docs.astral.sh/uv/getting-started/features/))
- [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) ([Node](https://nodejs.org/))
- [Go](https://go.dev/)
- [Rust](https://rust-lang.org/)
- [Zsh](https://zsh.sourceforge.io/) shell and [Starship](https://starship.rs/) prompt

AI pairing

- [Aider](https://aider.chat/) (CLI)
- [Roo Code](https://roocode.com/) (in [VS Code](https://code.visualstudio.com/))

DevOps

- [Homebrew](http://docs.brew.sh/Homebrew-on-Linux) for OS packages

## Prepare Your System

First, prepare your system

- [Chromebook](https://www.chromium.org/chromium-os/developer-library/guides/containers/containers-and-vms/): you must have a password: `sudo passwd $USER`
- Linux: `sudo apt update && sudo apt install git -y`
- Git [First Time Setup](https://git-scm.com/book/ms/v2/Getting-Started-First-Time-Git-Setup)
- SSH: Ensure your SSH keys are generated and added to your version control provider
    - [Github](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
- Clone the repo:
    - `git clone <repo-link>`
    - `cd <repo-name>`

## Scripts

Next, run the scripts

- **bootstrap:** Installs zsh with starship, core language runtimes, and system-level fixes; read `bootstrap.md`
- **ide:** Installs VS Code with a curated suite of extensions; read `ide.md`
