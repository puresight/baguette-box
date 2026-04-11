# <img src="https://www.vectorlogo.zone/logos/golang/golang-icon.svg" alt="Go logo" align="right" width="96" style="margin-top: -20px; border-left: 0.5em solid transparent;"> 🐹 Go

> [Go lang](https://go.dev/) is an open-source, statically typed, and compiled programming language (designed at Google by Robert Griesemer, Rob Pike, and Ken Thompson). It was created to address the challenges of large-scale software development, emphasizing simplicity, reliability, and efficiency.
> 
> Go features a clean, minimalist syntax inspired by C, but with reduced complexity (e.g., no class inheritance or operator overloading). It is well-known for its native support for concurrent programming through **goroutines** (lightweight execution threads) and channels for communication between them.
> 
> As a compiled language, it translates directly to machine code, offering performance (comparable to C++) without the overhead of a virtual machine. It includes **automatic garbage collection** which helps prevent memory leaks and manages memory allocation on the developer's behalf. One of its primary design goals was to significantly reduce build times for large projects.

- ↪️ Run recipe to [install with Mise](https://mise.jdx.dev/lang/go.html): `just install-go`

## 🕸️ WebAssembly

The standard Go compiler produces large binaries because it bundles the full Go runtime making [TinyGo](https://tinygo.org/) is the preferred toolchain for [WebAssembly](./wasm.md). TinyGo outputs leaner files and integrates cleanly if you already know Go, though it doesn’t support the complete Go standard library, which can be a limitation depending on what your code depends on.
