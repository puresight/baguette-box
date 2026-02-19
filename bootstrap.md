# Bootstrap

Bootstrap your developer workstation. This script provides a reproducible environment for a cloud-native developer stack.

- **System Layer:** 🐧 Apt handles OS-level packages (Podman, Keyrings)
- **Package Manager:** Homebrew manages the language stack and CLI tools
- **Shell UI:** Starship prompt

## How to Use

- `./bootstrap.sh`
- Restart your shell: Close and reopen the terminal (or run `exec zsh`) to activate Starship and Homebrew paths

## Quick-Start Editor

🐧 For quick file modifications, the [Nano](https://www.nano-editor.org/docs.php) is often bundled with your distribution.

## Caveats & Warnings

⚠ Important ⚠

- With podman, use rootless mode, and do not `sudo` for podman commands!

## Troubleshooting

- **Brew Not Found:** Run `source ~/.zprofile`.
- **Prompt Issues:** Ensure `eval "$(starship init zsh)"` is in `~/.zshrc`.
