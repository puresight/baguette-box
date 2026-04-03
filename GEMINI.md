# Baguette Box - Project Context

`baguette-box` is an AI-enabled developer environment bootstrap and configuration toolset designed for Debian-based systems and Fedora atomic Linux distributions (Bazzite, Silverblue, Bluefin, Aurora). It automates the setup of a professional workstation equipped for modern software development across Web, Mobile, Desktop, and Cloud, with a strong emphasis on Agentic AI integration.

## Project Overview

- **Primary Purpose**: Standardize and automate the installation of development tools, languages, and AI agents.
- **Core Philosophies**: 
  - **Just-in-time**: Install tools only when needed via modular recipes.
  - **AI-First**: Pre-configured for agentic workflows (Gemini, Goose, Aider, etc.).
  - **Modern Tooling**: Leverages `mise` for version management, `viteplus` for frontend management, and `uv` for Python/CLI tool management.

## Tech Stack & Architecture

### Management Tools
- **Task Runner**: `just` (see `justfile` as head of available recipes and modules).
- **Version Manager**: `mise` (preferred for most language SDKs and CLI tools).
- **Python/Tool Manager**: `uv` (used for Python environments and standalone CLI tools like Ansible).
- **Package Managers**: `apt` (Debian), `homebrew` (uBlue/macOS), `flatpak` (Linux GUI), `wasmer` (WebAssembly).

### Languages & Frameworks
Supports a wide range of ecosystems including:
- **Web**: Node.js, TypeScript (via `viteplus`), WebAssembly (Rust, Go, AssemblyScript).
- **Systems**: Rust (via `rustup`), Go, WebAssembly (Wasmer).
- **JVM**: Java (OpenJDK), Kotlin, Scala.
- **Mobile**: React Native (via `viteplus`), Flutter.
- **Desktop**: C#, .NET, Ruby on Rails, Elixir/Erlang, Haskell, Dart (Flutter).

### Agentic AI & IDE
- **IDEs**: VS Code (customized via `code/` directory), Antigravity, Goose.
- **AI Agents**: Gemini CLI, Ollama (local LLMs), Stockyard (LLM control plane).

## Key Directory Structure

- `/docs/specs/`: Authoritative specifications for the codebase
- `/docs/`: Documentation for specific technologies
- `/apt/`: APT repository templates (`.sources`) and package dependency lists (`apt.Packages`).
- `/code/`: VS Code configuration, including `user-settings.json` and extension lists (`code.Extensions`).
- `/scripts/`: Core logic for recipes of installations and system configurations.
  - `index.sh`: Deprecated library of installation functions.
  - `apt.sh`: APT source and package management logic.
- `justfile`: The entry point for all automation recipes.

## Building and Running

The project is a collection of setup scripts triggered by `just`.

### Common Recipes
- `just`: List all available recipes.
- `just bootstrap-debian`: Full bootstrap for a fresh Debian system (installs APT packages, configures shell, installs uv/viteplus).
- `just code`: Installs VS Code with pre-defined extensions and settings.
- `just install-<tool>`: Targeted installations (e.g., `just install-rust`, `just install-goose`, `just install-java`).
- `just display-versions`: Check the status of installed languages and major tools.

### Configuration
- Shell configuration logic is in `scripts/index.sh` under `configure_shell`.
- VS Code settings are managed via `scripts/lib/json.sh` which merges local JSON templates into the system config.

## Development Conventions

1. **Specifications**: Every new addition, change, or code transformation follows a spec.
2. **Modular Scripts**: Installation logic should be placed in `scripts/` and exposed via `justfile` recipes.
3. **Version Management**: Prefer `mise` for new language additions to maintain version flexibility.
4. **Template-Driven**: APT sources use `gomplate` templates in `/apt/` for DEB822 compatibility.
5. **Documentation**: Every major tool or language addition should have a corresponding `.md` file in `/docs/` that describes it, and tells the user how to install it.
6. **Testing**: Use the `_test-debian` or `_test-ublue` recipes in `justfile` to verify full environment builds.

## GEMINI.md Instructions
When interacting with this project:
- Always check the `justfile` for the "official" way to install or configure a tool.
- Refer to `scripts/*.sh` code for the underlying bash implementation of setup tasks.
- If adding a new tool, ensure it follows the pattern of:
  1. Adhere to its specification in `/docs/specs/`. If there is any contradiction or ambiguity, ask clarifying questions.
  2. Adding a dependency list in the relevant folder (e.g., `apt/`, `code/`, `homebrew/`).
  3. Adding an installation function in `scripts/`.
  4. Adding a recipe in `justfile`.
  5. Adding documentation in `docs/`.
