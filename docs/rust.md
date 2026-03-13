# Rust

> Rust is a general-purpose, multi-paradigm, systems programming language designed for high performance, memory safety, and thread safety. It achieves memory safety without a garbage collector through an innovative "ownership" system checked at compile time, which helps eliminate common bugs found in languages like C and C++.

## Installing Rust

We use [Rustup](https://rustup.rs/) to install the [Rust](https://rust-lang.org/) language.

## Installing Packages

We add the [cargo-binstall](https://github.com/cargo-bins/cargo-binstall) tool for quick package installation.

Because the standard _cargo install_ command downloads source code and compiles it on your machine, which can be slow. So to bypass this and install pre-compiled binaries, use the community-standard tools like cargo-binstall. This is the most popular method. it automatically searches for pre-compiled releases on GitHub or other registries. Usage: Replace `cargo install <package>` with `cargo binstall <package>`

- 📖 [2024/11 Ben Brandt: A Better Cargo Install Workflow: How I manage to keep the tools I've installed with cargo up-to-date](https://benjaminbrandt.com/a-better-cargo-install-workflow/)
- 📖 [2025/12 Sam Schlinkert: A curated list of command-line utilities written in Rust](https://github.com/sts10/rust-command-line-utilities)
