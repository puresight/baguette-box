# Chromebook Dev Workstation Bootstrap

## Purpose
This script provides a reproducible environment for a cloud-native developer stack (Node.js, Go, Rust, Python/uv) across multiple Chromebooks using Starship and Homebrew.

## How to Use
1. `sudo apt update && sudo apt install git -y`
2. `git clone <your-private-ssh-repo-link>`
3. `cd <repo-name>`
4. `./bootstrap.sh`
5. **Identity Setup** (See Manual Steps below)

## Core Architecture
* **System Layer:** Apt handles hardware-dependent fixes (Podman, Keyrings).
* **Package Manager:** Homebrew manages the language stack and GCC.
* **Shell Layer:** Starship provides a high-performance Rust-based prompt.

## Manual Steps (Post-Bootstrap)
Since this repository is public, PII is not included in the automation. Perform these steps once per machine:

1. **Configure Git Identity:**
   * `cp gitconfig.template ~/.gitconfig`
   * `nano ~/.gitconfig` (Enter your name and email locally)
2. **Set Local Password:**
   * `sudo passwd $USER` (Required for future sudo/brew prompts)

## Caveats & Warnings
* **Sudo Password:** You must set a local password for the script to handle Homebrew/Apt updates.
* **Git Identity:** Your `.gitconfig` is ignored by the repository to prevent PII leaks.
* **Podman:** Use rootless mode; avoid `sudo` for podman commands.

## Troubleshooting
* **Brew Not Found:** Run `source ~/.zprofile`.
* **Prompt Issues:** Ensure `eval "$(starship init zsh)"` is in `~/.zshrc`.
