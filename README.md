# baguette-box

This software serves to rapidly setup a new developer workstation. It is a reproducible system for setting up an AI-augmented development environment. Originally designed for high-performance Chromebooks (Crostini), it's evolving towards being cross-platform (Linux / Mac / Chromebook / WSL2).

## Tech stack

Languages

- Go
- Rust
- JavaScript (Node)

AI pairing contexts

- CLI: Aider
- IDE: Roo Code (in VS Code)

## Scripts

The setup is applied in layers:

- bootstrap: Installs core language runtimes (Node, Go, Rust, Python), the Starship shell, and system-level fixes; read `bootstrap.md`
- ide: Installs VS Code and a curated suite of verified extensions; read `ide.md`

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
