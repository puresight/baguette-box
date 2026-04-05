# Just migration

This is the plan to finish migrating this repo into a _Just_ recipes user interface.
This migration work involved planning, implementing, checking, testing, and documenting the additional _Just_ way of interfacing.

## Strategy & Goals

Modular, single-purpose shell scripts in the `./scripts/` directory will serve as the source of truth for task logic, potentially using shared helper functions from `./scripts/lib/`.

## Justfile

For simplicity and ease of discovery, a single, monolithic `justfile` will be used at the root of the repository. This keeps all recipes in one place, making them easy to find and manage during the initial migration phases. The work to modularize recipes is postponed indefinitely. It must not commence before this migration is finished, approved, and certified complete.

## Naming Convention

- **Consistent Casing:** To balance consistency with shell scripting best practices, the following convention will be used:
    - **`kebab-case`** for `just` recipe names, and the shell script filenames that implement them (e.g., `just install-java`, `scripts/install-json.sh`).
    - **`snake_case`** for the shell function names within those scripts (e.g., `function install_java { ... }`). This adheres to the Google Shell Style Guide and prevents potential issues with linters and static analysis tools.
- **Dependencies:** Recipe dependencies should be explicitly defined. For example, if building `mc` from source requires Mise, the recipe should be `install-mc: install-mise`. This creates a reliable execution graph.

## Cross-Platform Support

- The code that identifies the platform OS_FAMILY is `scripts/lib/platforms.sh`. It _should_ be sourced by every script in `./scripts/` directory.
- The scripts have been the primary place for handling cross-platform (`debian` vs `ublue`) differences.
- Use if/then or case statements with the $OS_FAMILY global to define OS-specific recipe parts, or library code e.g., invoking `scripts/debian/install-code.sh` vs `scripts/ublue/install-code.sh`).
- Isolating OS specific code could keep the shell scripts simpler and focused on a single platform's commands (e.g., `apt` vs `brew`) without bloating the `justfile` with inline shell logic.

## Work: Script Refactoring

**Goal:** Modularize the shell functions.

- Each public task function from `scripts/index.sh` (e.g., `install_code`) will be extracted into its own `kebab-case` script in the `scripts/` directory (e.g., `scripts/install-code.sh`). The function name inside the script will remain `snake_case` (e.g., `function install_code { ... }`).
- To allow direct execution by `just`, each extracted script must include an execution block at the bottom (e.g., `if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then install_code "$@"; fi`). This perfectly follows the pattern already established in `scripts/install-apt-packages.sh`.
- Each justfile recipe must be updated to use direct execution once a script is migrated.
- The `scripts/lib/` directory will hold shared, non-executable library functions that are sourced by the recipe scripts.
- `just` recipes will be updated to call the new, modular `kebab-case` scripts in `scripts/` directly, making them more efficient and self-contained.
