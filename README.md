# baguette-box

This software helps you rapidly set up a new developer workstation. It is a reproducible system for starting up an AI-augmented development environment instance. Originally designed for high-performance Chromebooks (Crostini), it's evolving towards being cross-platform (Linux / Mac / Chromebook / WSL2).

## Tech stack

Languages

- Python
- JavaScript (Node)
- Go
- Rust
- Zsh shell (with Starship)

AI pairing

- Aider (CLI)
- Roo Code (in VS Code)

DevOps

- Homebrew for OS packages

## Prepare Your System

First, prepare your system

- Chromebook: you must set a user password: `sudo passwd $USER`
- Linux: `sudo apt update && sudo apt install git -y`
- Git: [First Time Setup](https://git-scm.com/book/ms/v2/Getting-Started-First-Time-Git-Setup)
- SSH: Ensure your SSH keys are generated and added to your version control provider.
- Clone the repo:
    - `git clone <repo-link>`
    - `cd <repo-name>`

## Scripts

Next, run the scripts

- **bootstrap:** Installs core language runtimes, the Starship shell, and system-level fixes; read `bootstrap.md`
- **ide:** Installs VS Code with a curated suite of extensions; read `ide.md`
