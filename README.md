# baguette-box

This software helps you rapidly set up a new developer workstation. It is a reproducible system for starting up an AI-augmented development environment instance. Originally designed for high-performance Chromebooks (Crostini), it's evolving towards being cross-platform (Linux / Mac / Chromebook / WSL2).

## Tech stack

Languages

- Python
- JavaScript (Node)
- Go
- Rust

AI pairing contexts

- Aider (CLI)
- Roo Code (in VS Code)

## Scripts

The setup is applied in layers:

- **bootstrap:** Installs core language runtimes, the Starship shell, and system-level fixes; read `bootstrap.md`
- **ide:** Installs VS Code and a curated suite of verified extensions; read `ide.md`

On a fresh machine, do the following in sequence.

### Prepare Your System

- Linux: `sudo apt update && sudo apt install git -y`
- Git: Configure with your identity locally.
- SSH: Ensure your SSH keys are generated and added to your version control provider.
- Clone the repo

### Apply

```sh
git clone <your-repo-ssh-url>
cd baguette-box
./bootstrap.sh
./ide.sh
```
