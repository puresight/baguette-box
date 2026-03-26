# AssemblyScript

[AssemblyScript](https://www.assemblyscript.org/) is a programming language that provides a TypeScript-like syntax for compiling directly to **[WebAssembly](./wasm.md "wasm")**.
It is designed for developers already familiar with [TypeScript](./node.md) who want to create high-performance web applications without the steep learning curve of lower-level languages like Rust or C++.

By leveraging a strict subset of TypeScript's features, AssemblyScript produces lean, optimized Wasm modules ideal for performance-critical tasks in the browser, such as game development, data processing, and complex calculations.

## Should you use it?

### Why use AssemblyScript?

- To validate whether Wasm actually solves your performance bottleneck without requiring a massive time investment.
- To optimize: You need to move heavy computations (e.g., image processing, math algorithms, parsing) off the main thread to avoid UI blocking.
- For development speed: You need to ship a feature quickly and don't have weeks to learn a systems language.
- To build a library: You want to write a high-performance module that fits seamlessly into an existing JS/TS codebase. 

### Switch to [Rust](./rust.md) if

- Performance is critical: You are building a game engine, a real-time video editor, or complex cryptography where every millisecond and byte counts.
- You need memory safety guarantees: Rust's borrow checker prevents entire classes of bugs that can still occur in garbage-collected environments.
- You need specific native libraries: Rust has a massive crate ecosystem that can be compiled to Wasm, giving you access to mature tools that don't exist in the JS world. 

### Switch to [Go](./go.md) if

- You prefer simplicity: You want backend-like concurrency and a simple syntax without the mental overhead of Rust's memory model.
- You are already backend-curious: It serves as a great middle ground that is useful for both Wasm and robust server-side development. 

## Installing AssemblyScript

Local project installation is recommended. Installing locally keeps the compiler bundled with your project's specific dependencies.

- Install AssemblyScript as a development dependency: `npm install --save-dev assemblyscript`
- Scaffold the project:
Use npx to run the AssemblyScript [initialization tool](https://www.assemblyscript.org/getting-started.html) included with the package. This creates the necessary directory structure (/assembly, /build) and configuration files: `npx asinit .`
- Compile your code: after scaffolding, you can build your WebAssembly module using the script added to your package.json: `npm run asbuild`
