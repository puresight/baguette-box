# <img src="https://just.systems/favicon.ico" alt="Just logo" align="right" width="96" style="margin-top: 1ex; border-left: 0.1em solid transparent;"> Just

Once in this repo's root directory, using `just` to set up your environment is easy.

## About Just

[Just](https://just.systems/man/en/) is a handy command runner that saves and runs project-specific commands. It acts as a modern, simpler alternative to `make`, specifically designed for executing tasks rather than building software. 

Using `just` is a new best practice for project DevOps. It provides a clean, self-documenting interface for common tasks that can be consistently executed on local developer workstations and in CI/CD workflows (like GitHub Actions). By encapsulating complex shell logic within easy-to-remember recipes, it lowers the barrier to entry for contributing to projects. 

Many modern open source repositories are adopting Just to improve developer experience, including projects like Rust's [cargo-binstall](https://github.com/cargo-bins/cargo-binstall), [uv](https://github.com/astral-sh/uv), and the [just](https://github.com/casey/just) project itself.

## Configuration

This project uses a `justfile` at the root of the repository.

- **Environment Configuration**: We utilize a `.env` file to separate user-specific configuration from the core task logic; the root `justfile` automatically [loads environmental variables into the execution context](https://just.systems/man/en/settings.html) using the `set dotenv-load := true` directive.
