# Rust

> [Rust](https://rust-lang.org/) is a general-purpose, multi-paradigm, systems programming language designed for high performance, memory safety, and thread safety. It has rapidly ascended to the forefront of modern software development by successfully bridging the gap between high-level abstraction and low-level performance. That unique ownership model guarantees memory safety without a garbage collector, effectively eliminating common bugs like null pointer dereferences and data races. As industries shift toward more secure and concurrent systems, Rust’s robust ecosystem and enthusiastic community have solidified its position as the preferred successor to [C](https://www.c-language.org/) and [C++](https://isocpp.org/) for critical infrastructure, web applications, and performance-sensitive software.

- ↪️ Run recipe `just install-rust`
- [Rustup](https://rustup.rs/) will install the default toolchain specified in _your_ `~/.rustup/settings.toml` _if it exists._
- Cargo's bin directory is `~/.cargo/bin`

## Packages

We add the [cargo-binstall](https://github.com/cargo-bins/cargo-binstall) tool for quick package installation.

Usage: Replace `cargo install <package>` with `cargo binstall <package>`

Because the standard _cargo install_ command downloads source code and compiles it on your machine, which can be slow. So to bypass this and install pre-compiled binaries, use the community-standard tools like cargo-binstall. This is the most popular method. It automatically searches for pre-compiled releases on GitHub or other registries.

- 📖 [2024/11 Ben Brandt: A Better Cargo Install Workflow: How I manage to keep the tools I've installed with cargo up-to-date](https://benjaminbrandt.com/a-better-cargo-install-workflow/)
- 📖 [2025/12 Sam Schlinkert: A curated list of command-line utilities written in Rust](https://github.com/sts10/rust-command-line-utilities)

## WebAssembly

Rust is the [gold standard](https://thebackenddevelopers.substack.com/p/webassembly-on-the-server-secure) for [WebAssembly](./wasm.md) development. Developers use the standard `rustc` compiler with the `wasm32-wasi` target to create lean, secure binaries. It offers the most mature ecosystem for [Kubernetes integration](https://developer.okta.com/blog/2022/01/28/webassembly-on-kubernetes-with-rust).

- 📖 Book: _[Rust and WebAssembly](https://rustwasm.github.io/docs/book/)_
- [Leptos](https://medium.com/@priya.raimagiya/the-5-best-rust-frontend-frameworks-reviewed-for-2026-4694dad8f181) is the mainstream choice for high-performance Wasm apps, using "Signals" (similar to SolidJS) but with Rust’s type guarantees.
- [Yew](https://medium.com/@priya.raimagiya/the-5-best-rust-frontend-frameworks-reviewed-for-2026-4694dad8f181) alternative
