# <img src="https://www.google.com/s2/favicons?sz=128&domain=claude.com" alt="Claude logo" align="right" width="96" style="margin-top: 1ex; border-left: 0.1em solid transparent;"><!-- <img src="https://www.google.com/s2/favicons?sz=128&domain=anthropic.com"> --> Claude Code

## CLI

[Claude Code](https://code.claude.com/docs/en/overview) CLI brings the power of Anthropic's state-of-the-art language models, particularly those fine-tuned for coding, directly to your command line. It serves as an intelligent coding companion, helping you with code generation, explanation, and refactoring tasks.

- ↪️ Run recipe: `just install-claude-code`
- To authenticate with your Anthropic account: `claude-code login`

## GUI

### Claude Cowork

Sadly, Anthropic does not provide desktop app support for Linux, yet. Write them to request it. But the community hacked a macOS version of [Claude Cowork](https://claude.com/product/cowork) (called
[claude-cowork-linux](https://github.com/johnzfitch/claude-cowork-linux?tab=readme-ov-file#readme)) so on Fedora Atomic Desktop Linux /
[uBlue](https://universal-blue.org/) you can create a Fedora container and experiment.

## Privacy & Opt-out

Claude Code uses your Anthropic account settings to determine if your data is used for model training.

1.  **Disable Training:** Log in to [claude.ai](https://claude.ai), go to **Settings > Privacy**, and toggle OFF **"Help improve Claude"**.
2.  **Commercial Users:** If you are using a Team or Enterprise account, you are **automatically opted out** by default.
3.  **Disable Surveys:** To prevent the CLI from asking for feedback, add this to your shell configuration (`.bashrc` or `.zshrc`):
    ```bash
    export CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY=1
    ```
4.  **Local History:** Session logs are stored locally for 30 days in `~/.claude/projects/`. You can delete these manually if needed.

### Official Resources
- [Anthropic Trust Center](https://trust.anthropic.com) — Compliance artifacts and security controls.
- [Anthropic Privacy Policy](https://www.anthropic.com/legal/privacy) — Official legal terms.
- [Anthropic Privacy Center](https://support.anthropic.com/en/collections/10100725-anthropic-privacy-center) — Detailed data protection articles.
