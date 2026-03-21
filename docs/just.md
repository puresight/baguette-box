# Just Command Runner

[Just](https://just.systems/man/en/) is a handy command runner that saves and runs project-specific commands. It acts as a modern, simpler alternative to `make`, specifically designed for executing tasks rather than building software. 

Using `just` is a new best practice for project DevOps. It provides a clean, self-documenting interface for common tasks that can be consistently executed on local developer workstations and in CI/CD workflows (like GitHub Actions). By encapsulating complex shell logic within easy-to-remember recipes, it lowers the barrier to entry for contributing to projects. 

Many modern open source repositories are adopting Just to improve developer experience, including projects like Rust's `cargo-binstall`, `uv`, and the `just` project itself.

## Setup Instructions

Instead of using the legacy `./box.sh` script, you can now use `just` to set up your environment:

1. **For IT professionals using Ansible:**
   Run `just ansible`

2. **Bootstrap your system:**
   Run `just bootstrap`

3. **Code:**
   Run `just code`

To see a list of all available recipes and tasks, simply run:
```bash
just
```

## Architecture & Configuration

This project uses a `justfile` at the root of the repository. This approach keeps all recipes in one place, making them easy to find and manage.

- **Environment Configuration**: We utilize a `.env` file to separate user-specific configuration from the core task logic. The root `justfile` automatically loads environmental variables into the execution context using the `set dotenv-load := true` directive.
