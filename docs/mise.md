# Mise

> Mise-en-place is a polyglot runtime and tool manager! `mise` is a high-performance, _asdf_-compatible tool manager written in Rust. It serves as a unified interface for managing project-specific runtimes, environment variables, and tasks, effectively replacing the need for fragmented tools like `nvm`, `pyenv`, `direnv`, and `make`.

- ↪️ Recipe to install: `just install-mise`

## Core Architecture & Primitives

- **Shims vs. Path Manipulation:** Unlike `asdf`, which relies on shims by default (introducing execution overhead), `mise` primarily uses **PATH modification**. It dynamically injects the correct binary paths into the shell session upon directory entry.
- **The Config Hierarchy:** Tool versions are resolved via a deterministic lookup:
  1.  `MISE_VERSION` environment variables.
  2.  Local config: `.mise.toml` or `mise.toml`.
  3.  Legacy files: `.tool-versions` (asdf compatibility), `.node-version`, `.python-version`.
  4.  Global config: `~/.config/mise/config.toml`.
- **Backends:** `mise` supports multiple installation backends, including **asdf plugins**, native core repositories (for high-speed installs of Node, Ruby, Python, etc.), and **vfox**.

## Configuration & Tool Management

The `.mise.toml` file is the central manifest for project environments. It supports version ranges, auto-installations, and environment-specific overrides.

| Feature                  | Description                                                                |
| :----------------------- | :------------------------------------------------------------------------- |
| **Shorthands**           | Allows `mise install node@20` instead of full plugin URLs.                 |
| **Virtual Environments** | Native support for Python `venv` and Ruby `bundle` integration.            |
| **Global Aliases**       | Map custom names to specific versions (e.g., `prod` -> `1.2.3`).           |
| **Lazy Loading**         | Plugins are only fetched/cached when a specific tool version is requested. |

## Environment & Task Orchestration

Beyond versioning, `mise` integrates environment variable management and a task runner, reducing context switching.

- **Environment Sync (`direnv` replacement):** You can define env vars directly in `mise.toml`. It supports **SOPS** or **1Password** integration for secure secret injection without plaintext `.env` files.
- **Task Runner:** Defines project-specific scripts with dependency graphs.
  - **Features:** File watching (`--watch`), requirements (ensure `db` is up before `test`), and parallel execution.
  - **Syntax:** Tasks are defined in `[tasks]` blocks using shell-like syntax or references to external scripts.

## Developer Workflow: Quick Reference

```bash
# Bootstrap an environment
mise install        # Installs all tools defined in .mise.toml
mise use node@latest # Pins the latest LTS to the current directory

# Execution
mise exec -- npm start # Runs a command within the mise-loaded PATH
mise run build         # Executes a defined task from mise.toml

# Diagnosis
mise doctor  # Validates shim integrity and PATH health
mise ls      # Lists currently active and installed tool versions
```

## Performance & Security

Binary Speed: Written in Rust, mise is significantly faster than shell-script-based managers, with negligible latency added to shell startup (typically <5ms).

Strict Hash Verification: Supports checksum verification for downloads to prevent supply chain attacks during tool acquisition.

## References

### Official Documentation

- **[Core Concepts & Glossary](https://mise.jdx.dev/glossary.html):** Definitions for Mise-specific primitives like **Activation**, **Backends**, and **Toolsets**.
- **[Configuration Reference](https://mise.jdx.dev/configuration.html):** Detailed specification for the `mise.toml` hierarchical configuration and merging logic.
- **[Task Runner Orchestration](https://mise.jdx.dev/tasks/):** Deep dive into defining task dependency graphs, parallel execution, and the file-watching mechanism.
- **[Environment Management](https://mise.jdx.dev/environments/):** Documentation on `direnv` replacement, environment variable templates, and secret redaction.
- **[Comparison to asdf](https://mise.jdx.dev/dev-tools/comparison-to-asdf.html):** A technical breakdown of the architectural differences between **PATH manipulation** and **shims**.

### Reputable 3rd-Party Guides

- **[Just Use Mise (Atomic Spin)](https://spin.atomicobject.com/just-use-mise/):** A senior perspective on the reliability and predictability benefits of Mise over legacy managers.
- **[Using Mise for All the Things (Jarv.org)](https://jarv.org/posts/mise/):** A practical guide to consolidating `Make`, `direnv`, and `entr` into a single Mise workflow.
- **[Mise vs. asdf for JS Environment Management (LogRocket)](https://blog.logrocket.com/mise-vs-asdf-javascript-project-environment-management/):** A deep dive into the performance implications of the Rust-based execution model.
