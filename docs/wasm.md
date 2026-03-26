# WebAssembly

[WebAssembly](https://www.cncf.io/blog/2024/03/12/webassembly-on-kubernetes-from-containers-to-wasm-part-01/) ("wasm") is an open standard that defines a portable binary-code format for executable programs. It is designed as a high-performance compilation target for programming languages like [Rust](./rust.md) and [Go](./go.md), enabling deployment on the web for client and server applications. Wasm modules are sandboxed, providing a secure execution environment, and can be run at near-native speed. This makes it a powerful technology for building performant, secure, and portable software for a wide range of platforms beyond the browser.

## Wasmer

> [Wasmer](https://wasmer.io/) is a high-performance, open-source runtime for WebAssembly that allows developers to run Wasm modules on the server, at the edge, or on any device. It acts as a universal binary format, enabling sandboxed, near-native speed execution of code. For developers, this means you can build portable, secure, and efficient applications that are isolated from the host system, making it ideal for plugin systems, serverless functions, and cross-platform tooling. It has a module/package manager (which functions like `npm` for JavaScript or `cargo` for Rust) that allows developers to publish, share, and consume Wasm packages from a central registry. You can use the CLI to install packages globally or integrate them into your projects, simplifying dependency management and accelerating development by leveraging a growing library of community-contributed modules.

- ↪️ Recipe to [install from Github with Mise](https://mise.jdx.dev/dev-tools/backends/github.html): `just install-wasmer`

### Get started

- Run a local .wasm file: `wasmer run my_app.wasm`
- Initialize a project: `wasmer init` (creates a _wasmer.toml_ file)
- Run a wasm modules from the Wasmer registry: `wasmer run syrusakbary/cowsay "Hello World"`
