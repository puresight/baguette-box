# Dev Workstation Bootstrap

## Purpose
This script provides a reproducible environment for a cloud-native developer stack (Node.js, Go, Rust, Python/uv) across multiple systems using Starship and Homebrew.

## How to Use
1. `sudo apt update && sudo apt install git -y`
2. `git clone <your-private-ssh-repo-link>`
3. `cd <repo-name>`
4. `./bootstrap.sh`
5. **Identity Setup** (See Manual Steps below)
6. **Restart Shell:** Close and reopen the terminal (or run `exec zsh`) to activate Starship and Homebrew paths.

## Core Architecture
* **System Layer:** Apt handles hardware-dependent fixes (Podman, Keyrings).
* **Package Manager:** Homebrew manages the language stack, GCC, and CLI tools.
* **Shell Layer:** Starship provides a high-performance Rust-based prompt.

## Quick-Start Editor
For quick file modifications (like editing your `.gitconfig`), the **Micro** text editor is included. 
* To use it: `micro <filename>`
* Key shortcuts: `Ctrl+S` (Save), `Ctrl+Q` (Quit), `Ctrl+C` (Copy), `Ctrl+V` (Paste).

## Manual Steps (Post-Bootstrap)
Since this repository is public, PII is not included in the automation. Perform these steps once per machine:

1. **Configure Git Identity:**
   * `cp gitconfig.template ~/.gitconfig`
   * `micro ~/.gitconfig` (Enter your name and email locally)
2. **Set Local Password:**
   * `sudo passwd $USER` (Required for future sudo/brew prompts)

## Caveats & Warnings
* **Sudo Password:** You must set a local password for the script to handle Homebrew/Apt updates.
* **Git Identity:** Your `.gitconfig` is ignored by the repository to prevent PII leaks.
* **Podman:** Use rootless mode; avoid `sudo` for podman commands.

## Troubleshooting
* **Brew Not Found:** Run `source ~/.zprofile`.
* **Prompt Issues:** Ensure `eval "$(starship init zsh)"` is in `~/.zshrc`.
