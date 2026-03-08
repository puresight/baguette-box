# Plan: Migrate Node and Go to Mise

## Overview

This plan details the steps required to transition the repository's dependency management for Node.js and Go from Homebrew to [Mise](https://mise.jdx.dev/). This aligns with the "Cattle not pets" philosophy by ensuring deterministic, version-controlled toolchains, and addresses the "Mise: onboard Go & Node" roadmap item.

## Phases

### Preparation

1.  **Audit Current Usage**:
    - Scan `Brewfile`, `./lib/bootstrap.sh`, or other setup scripts for `brew install node` and `brew install go`.
    - Note the current versions in use to ensure continuity.

### Configuration

1.  **Create Configuration File**:
    - Create a `mise.toml` (preferred) or `.tool-versions` file in the repository root.
    - Pin specific versions for consistency.
    ```toml
    [tools]
    node = "lts"      # or specific version like "20.11.0"
    go = "latest"     # or specific version like "1.22.0"
    ```
2.  **Version Control**:
    - Ensure `mise.toml` is committed to git so all developers share the same version configuration.

### Implementation

1.  **Update Installation Scripts**:
    - Modify any bootstrap scripts (e.g., `./lib/bootstrap.sh`).
    - **Add Task**: Add a function `install_mise_tools` to `./lib/bootstrap.sh`. This function should execute `mise install`.
    - **Ensure Prerequisite**: Ensure `mise` itself is installed by task `install_mise` in `workstation.yaml` before `install_mise_tools` runs.

2.  **Update Configuration (`workstation.yaml`)**:
    - Add the `install_mise_tools` task to the installation flow.
    - Disable tasks that trigger `brew bundle` or specific `brew install` commands for Node/Go.

3.  **Update `Brewfile`**:
    - Comment out or remove lines for Node and Go:
      ```ruby
      # brew "go"
      # brew "node"
      ```

4.  **Uninstall Homebrew Dependencies**:
    - Execute uninstallation on local machines to prevent path conflicts.
      ```bash
      brew uninstall node go
      brew autoremove
      ```

### Verification

1.  **Path Check**:
    - Run `which node` and `which go`. They should point to `~/.local/share/mise/...` (or the configured Mise data path), not `/opt/homebrew/...` or `/usr/local/...`.
2.  **Version Check**:
    - Run `node --version` and `go version` to confirm they match the configuration in `mise.toml`.
3.  **Build Check**:
    - Run the project build process to ensure the environment is stable and tools function as expected.
4.  **Idempotency**:
    - Run `box.sh` to ensure the new configuration applies cleanly on a fresh or existing setup.

### Documentation

1. Update docs/README.md with information about the new function/task install_mise_tools to install mise managed tools including Node, Go.
   - Replace Homebrew prerequisites with Mise instructions.
   - Document how to upgrade versions using `mise up`.
2. Update `plan/README.md` to mark "Mise: onboard Go & Node" as completed.
