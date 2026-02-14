# Chromebook Dev Workstation Bootstrap

## Purpose
This script provides a reproducible, "single-source-of-truth" environment for a cloud-native developer stack (Node.js, Go, Rust, Python/uv) across multiple Chromebooks. It focuses on a "minimalist-but-powerful" setup using Starship instead of bulky frameworks.

## How to Use
On a fresh Linux (Crostini/Baguette) container:
1. `sudo apt update && sudo apt install git -y`
2. `git clone git@github.com:your-username/your-repo-name.git`
3. `cd your-repo-name`
4. `./bootstrap.sh`

## Core Architecture
* **System Layer (Apt):** Handles hardware-dependent fixes (Podman, GPU, Keyrings) and the base Zsh shell.
* **Package Manager (Homebrew):** Manages the language stack and GCC to ensure parity across ChromeOS versions.
* **Shell Layer (Starship):** A high-performance Rust-based prompt replacing Oh My Zsh for better speed and portability.

## Limitations & Scope
* **ChromeOS Specific:** Designed for Debian-based Crostini/Baguette containers.
* **Architecture:** Automatically handles x86_64; handles the `linuxbrew` pathing dynamically.
* **No GUI:** Install Linux desktop apps (e.g., VS Code) via ChromeOS `.deb` installers for hardware optimization.

## Caveats & Warnings
* **Sudo Password:** Ensure you have set a local password via `sudo passwd $USER` before running, as Homebrew and Apt require it.
* **Shell Initialization:** The script appends to `.zprofile` and `.zshrc`. If you re-run the script, it uses `grep` to avoid duplicate entries.
* **Podman:** Configured for **rootless** mode. Avoid using `sudo` with `podman` commands.
* **Idempotency:** The script is safe to run multiple times; it will only install missing components and verify the existing state.

## Troubleshooting
* **Brew Not Found:** If `brew` is missing after installation, run `source ~/.zprofile`.
* **Prompt Issues:** If the Starship prompt doesn't appear, ensure `eval "$(starship init zsh)"` is at the bottom of your `~/.zshrc`.
