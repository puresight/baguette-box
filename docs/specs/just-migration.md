# Just migration

This is the plan to start migrating this repo into a _Just_ recipes user interface.
This migration work involves planning, implementing, checking, testing, and documenting the additional _Just_ way of interfacing.

## Strategy & Goals

- **Additive First:** The initial migration will introduce `just` as a parallel, preferred interface without removing the existing `box.sh` and YAML-based workflow. The long-term goal is to consolidate the control flow through `just`.
- **Single Source of Truth:** Modular, single-purpose shell scripts in the `./scripts` directory will serve as the source of truth for task logic, potentially using shared helper functions from `./scripts/lib/`. The `justfile` recipes will act exclusively as an orchestration and parameter-passing layer on top of them.
- **Improved User Experience:** `just` will become the primary documented way to interact with the repository, offering a simpler, more memorable command structure than `./box.sh <config>.yaml`.

## Architecture & Design

### Modular Justfiles

To maintain clarity and organization, the root `justfile` should be minimal. It will be responsible for loading environment configuration and including other, more specific `justfile`s.

- Create a `justfiles/` directory.
- Specific domains will have their own files, e.g., `justfiles/languages.just`, `justfiles/tools.just`, `justfiles/bootstrap.just`.
- The root `justfile` will use `!include` directives to pull them in.

### Configuration Management

- **Environment File:** A `.env` file will be used for user-specific configuration. The root `justfile` should load this using `set dotenv-load := true`. This separates user config from the task logic. (Remember to explain this in the dev documentation later.)
- **Parameter Passing:** Just recipes will accept arguments and pass them to the underlying shell scripts. The convention should be clear. For example, `install_ms_openjdk '17' '21'` becomes `just install-java 17 21`.

### Naming Convention

- **Consistent Casing:** To balance consistency with shell scripting best practices, the following convention will be used:
    - **`kebab-case`** for `just` recipe names, YAML task names, and the shell script filenames that implement them (e.g., `just install-java`, `task: install-java`, `scripts/install-java.sh`).
    - **`snake_case`** for the shell function names within those scripts (e.g., `function install_java { ... }`). This adheres to the Google Shell Style Guide and prevents potential issues with linters and static analysis tools.
- **Dependencies:** Recipe dependencies should be explicitly defined. For example, if building `mc` from source requires Go, the recipe should be `install-mc: install-go`. This creates a reliable execution graph.
- **Help Text:** Every recipe intended for users should have a comment above it explaining its purpose. The default recipe should be `just --list` to provide a helpful starting point for users.

### Cross-Platform Support

The `justfile` will be the primary mechanism for handling cross-platform differences, aligning with the project's roadmap, while strictly respecting the `AGENTS.md` directive to keep `justfile` logic minimal.
- Use `[if os == "..."]` attributes to define OS-specific recipes that dispatch execution to single-platform shell scripts (e.g., invoking `scripts/linux/install-code.sh` vs `scripts/macos/install-code.sh`).
- This keeps the shell scripts simpler and focused on a single platform's commands (e.g., `apt` vs `brew`) without bloating the `justfile` with inline shell logic.

## Migration Phases

1.  **Phase 1: Additive Implementation**
    - Create the `justfile` structure as described above.
    - Implement recipes that wrap the existing shell functions. Initially, these recipes can source `scripts/index.sh` to gain access to the task functions.
    - **Update YAML files:** Convert all `task` names in `bootstrap.yaml`, `code.yaml`, and `ansible.yaml` from `snake_case` to `kebab-case` to align with the new `just` recipe names.
    - **Update `box.sh`:** Modify `box.sh` to handle the new `kebab-case` task names. For backward compatibility with the existing `snake_case` shell functions, `box.sh` will temporarily translate the `kebab-case` task name back to `snake_case` before calling `eval` (e.g., `install-java` becomes `install_java`).
    - As a first step in refactoring, extract the `eget` and `gomplate` installation logic from `box.sh` and `scripts/index.sh` into new, dedicated scripts (`scripts/install-eget.sh`, `scripts/install-gomplate.sh`). The `eget` logic is in `index.sh`, while the `gomplate` logic is in `box.sh`. Create corresponding `just` recipes in `justfiles/tools.just` that call these scripts. These will serve as dependencies for other recipes, replacing the prerequisite installation logic in `box.sh`.
    - Replicate the logic of `bootstrap.yaml`, `code.yaml`, etc., as high-level recipes (e.g., `just bootstrap`, `just code`).
    - Move the legacy YAML/dispatcher documentation from the main `README.md` into a new `docs/legacy-box-usage.md` file.
    - Update documentation (`README.md`, `docs/just.md`) to feature the `just` commands as the primary, recommended workflow. `box.sh` remains fully functional for backward compatibility.

2.  **Phase 2: Script Refactoring**
    - **Goal:** Decouple task logic from orchestration by modularizing the shell functions.
    - **Strategy:** Each public task function from `scripts/index.sh` (e.g., `install_code`) will be extracted into its own `kebab-case` script in the `scripts/` directory (e.g., `scripts/install-code.sh`). The function name inside the script will remain `snake_case` (e.g., `function install_code { ... }`).
    - To allow direct execution by `just`, each extracted script must include an execution block at the bottom (e.g., `if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then install_code "$@"; fi`). This perfectly follows the pattern already established in `scripts/lib/java.sh`.
    - The `scripts/lib/` directory will hold shared, non-executable library functions that are sourced by the recipe scripts.
    - For backward compatibility, `scripts/index.sh` will be refactored. Instead of containing logic, it will become a thin aggregator that simply sources all the recipe scripts from `scripts/`. This ensures the legacy `box.sh` continues to work.
    - The `kebab-case` to `snake_case` translation logic in `box.sh` will remain in place during this phase.
    - `just` recipes will be updated to call the new, modular `kebab-case` scripts in `scripts/` directly, making them more efficient and self-contained.

3.  **Phase 3: Engine Consolidation**
    - **Goal:** Establish `just` as the single execution engine to eliminate dual orchestration paths.
    - Refactor `box.sh`. Instead of sourcing `scripts/index.sh` and using `eval`, it will be simplified to parse the legacy YAML files and execute the corresponding `just` recipes.
    - The refactored `box.sh` must first ensure `just` is installed, using the same installation method that will be recommended to users in the main documentation. This makes the legacy entrypoint a reliable gateway to the new `just`-based engine.
    - For example, a YAML task for `install-dotnet` with argument `8` would cause `box.sh` to execute `just install-dotnet 8`. The temporary string translation logic in `box.sh` is removed at this stage, as it no longer calls the shell functions directly.
    - This change makes `just` the single source of truth for task *orchestration*, while preserving the familiar `box.sh` interface for backward compatibility.

4.  **Phase 4: Deprecation and Future Work**
    - After a suitable transition period, the `box.sh` script and associated YAML configuration files can be fully deprecated and removed.
    - All documentation will be updated to reflect a `just`-only workflow.
    - This sets the stage for future work, such as a declarative, stateless interface layered on top of the `just` foundation.

## Tactics & Resources

- Use `bootstrap.yaml` & `code.yaml` & `ansible.yaml` lists of tasks (with arguments) as the primary source for defining the high-level recipes and their constituent steps.

## Documentation

- Write a `just.md` file in the `docs` directory with a paragraph summary of what Just is, including a hyperlink to the 📖 [Just Programmer's Manual](https://just.systems/man/en/).
    - Explain how Just is a new best practice for project DevOps that can be used on workstations and in CI/CD workflows (e.g. in Github Actions).
    - Give a short list of illustrative and practical examples of open source repos using Just correctly.
    - Include a Just version of the setup instructions, replacing the `./box.sh` commands.
- Add instructions to the repo's main `README.md` for installing the `just` prerequisite. The instructions should point users to `docs/chromeos.md` for initial environment setup and then provide the specific `sudo apt install just` command for Debian 12.
- The `docs/just.md` file should also document the architectural decisions made here, such as the modular file structure and use of `.env`.
