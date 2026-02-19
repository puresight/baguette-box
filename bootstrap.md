# Dev Workstation Bootstrap

Bootstrap your dev workstation

## Purpose

This script provides a reproducible environment for a cloud-native developer stack (Node.js, Go, Rust, Python/uv) across multiple systems using Starship and Homebrew.

## How to Use

- `./bootstrap.sh`
- Restart your shell: Close and reopen the terminal (or run `exec zsh`) to activate Starship and Homebrew paths

## Core Architecture

- **System Layer:** Apt handles hardware-dependent fixes (Podman, Keyrings).
- **Package Manager:** Homebrew manages the language stack, GCC, and CLI tools.
- **Shell Layer:** Starship provides a high-performance Rust-based prompt.

## Quick-Start Editor

For quick file modifications (like editing your `.gitconfig`), the **Micro** text editor is included. 
* To use it: `micro <filename>`
* Key shortcuts: `Ctrl+S` (Save), `Ctrl+Q` (Quit), `Ctrl+C` (Copy), `Ctrl+V` (Paste).

## Caveats & Warnings
- **Sudo Password:** You must set a local password for the script to handle Homebrew/Apt updates.
- **Git Identity:** Your `.gitconfig` is ignored by the repository to prevent PII leaks.
- **Podman:** Use rootless mode; avoid `sudo` for podman commands.

## Troubleshooting

- **Brew Not Found:** Run `source ~/.zprofile`.
- **Prompt Issues:** Ensure `eval "$(starship init zsh)"` is in `~/.zshrc`.
