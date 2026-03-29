# Vite+

[Vite+](https://viteplus.dev/) is an integrated, high-performance toolchain for modern web development that streamlines project setup and maintenance. It manages Node.js runtimes and package managers, ensuring consistent environments across projects. By bundling fast, Rust-based tools, it provides a unified interface for static analysis (`vp check` using Oxfmt and Oxlint), testing (`vp test` via Vitest), and task running, aiming to be a comprehensive solution for the entire development lifecycle.

Developers should adopt Vite+ to boost productivity and ensure code quality through its unified, performance-oriented architecture. It replaces a fragmented collection of tools like `nvm`, `Prettier`, and `ESLint` with a single, cohesive command-line interface, reducing configuration overhead. The use of high-speed, Rust-based components near-instant feedback, while integrated version management eliminates environment-related inconsistencies, allowing developers to focus more on building features and less on wrangling tools.

## Building

[Vite JS](https://vitejs.dev/) is a modern frontend build tool designed for speed and a leaner developer experience. It serves as a fast alternative to older tools like Webpack by leveraging native ES modules for instant server starts and lightning-fast Hot Module Replacement (HMR).

## Linting & Checking

Oxfmt & Oxlint

`vp check` (Lint + Format + Type-check) is the default command for fast static checks in Vite+. It brings together formatting through [Oxfmt](https://oxc.rs/docs/guide/usage/formatter.html), linting through [Oxlint](https://oxc.rs/docs/guide/usage/linter.html), and TypeScript type checks through [tsgolint](https://oxc.rs/docs/guide/usage/linter/type-aware.html).

## Testing

Vitest

`vp test` is built on [Vitest](https://vitest.dev/) so you get a Vite-native test runner that reuses your Vite config and plugins, supports [Jest](https://jestjs.io/) style [expectations](https://jestjs.io/docs/expect#expect), snapshots, and coverage, and handles modern ESM, TypeScript, and JSX projects cleanly.

## Editing

[VS Code integration](https://viteplus.dev/guide/ide-integration): VitePlus has settings that `vp create` and `vp migrate` can automatically write into the project.

- extension pack: `VoidZero.vite-plus-extension-pack`
- url: https://marketplace.visualstudio.com/items?itemName=VoidZero.vite-plus-extension-pack
- Replaces Prettier for format
