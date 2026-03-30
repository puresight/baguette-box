# Vite+

[Vite+](https://viteplus.dev/) is an integrated, high-performance toolchain for modern web development that streamlines project setup and maintenance. It manages Node.js runtimes and package managers, ensuring consistent environments across projects. By bundling fast, Rust-based tools, it provides a unified interface for static analysis (`vp check` using Oxfmt and Oxlint), testing (`vp test` via Vitest), and task running, aiming to be a comprehensive solution for the entire development lifecycle.

Developers should adopt Vite+ to boost productivity and ensure code quality through its unified, performance-oriented architecture. It replaces a fragmented collection of tools like `nvm`, `Prettier`, and `ESLint` with a single, cohesive command-line interface, reducing configuration overhead. The use of high-speed, Rust-based components near-instant feedback, while integrated version management eliminates environment-related inconsistencies, allowing developers to focus more on building features and less on wrangling tools.

## Installing

Vite+ takes control of the [Node](./node.md) runtime environment by managing its installation and versioning directly. This eliminates "works on my machine" problems by ensuring that every developer on a project, as well as CI/CD pipelines, uses the exact same version of Node. By abstracting away the need for separate version managers like `nvm` or `asdf`, Vite+ provides a single, reliable command to set up and maintain the project's foundational runtime, simplifying onboarding and guaranteeing a consistent execution environment.

## Packaging

In addition to managing the Node.js runtime, Vite+ provides its own integrated package manager. This replaces the need for external tools like `npm`, `yarn`, or `pnpm`, creating a more cohesive development experience. The package manager is designed for performance, leveraging modern techniques to speed up dependency installation and updates. By handling both the runtime and its packages, Vite+ ensures that the entire dependency graph is consistent and reproducible, further reducing configuration drift and simplifying project maintenance.

## Checking

Vite+ streamlines static analysis with the `vp check` command, a high-performance tool that unifies formatting, linting, and type-checking. By leveraging the Rust-based Oxc toolchain (including Oxfmt, Oxlint, and a TypeScript-aware linter), it provides near-instant feedback.

The `vp check` command is your primary tool for validating the entire project from the terminal. It's designed to be fast and efficient, making it easy to run frequently during development.
For many common linting and formatting problems, Vite+ can fix them automatically: the `vp check --fix` command applies formatting rules and resolves simple lint errors without manual intervention, saving significant time.

By adding a check step to your GitHub Actions workflow, you can validate every pull request. If the check fails, the pipeline fails, blocking the merge and notifying the developer to fix the issues.

```yaml
jobs:
  quality_check:
    name: Code Quality Check
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: vite-plus/setup-action@v1 # Use the official Vite+ setup action
      - run: vp check # Fails the pipeline if issues are found
```

## Editing

Vite+ deeply integrates with VS Code to provide a zero-config development environment. Upon project setup with `vp create` or `vp migrate`, it automatically generates workspace settings (`.vscode/settings.json`) that enable features like format-on-save. These settings work with the official extensions to provide instant, in-editor feedback from its fast tools. This ensures that code quality and formatting are consistently enforced without requiring developers to manually configure their editor. Because the IDE uses the exact same tools and configuration as the CLI and CI pipeline, you get a consistent, reliable DX. For more details, read the official [guide for VS Code IDE integration](https://viteplus.dev/guide/ide-integration).

- Code extension pack: [`VoidZero.vite-plus-extension-pack`](https://marketplace.visualstudio.com/items?itemName=VoidZero.vite-plus-extension-pack).

## Building

[Vite](https://vitejs.dev/) is a modern frontend build tool designed for speed and a leaner developer experience. It serves as a fast alternative to older tools like Webpack by leveraging native ES modules for instant server starts and lightning-fast Hot Module Replacement (HMR).

## Testing

Vite+ integrates testing through the `vp test` command, which is powered by [Vitest](https://vitest.dev/). This provides a modern, high-performance testing experience that is deeply integrated with the Vite ecosystem. Unlike traditional test runners like Jest, which require separate and often complex configurations to handle TypeScript and ESM, Vitest reuses your existing Vite configuration out-of-the-box. This eliminates configuration drift and simplifies setup significantly.

The primary advantage is speed and developer experience. Vitest leverages Vite's instant Hot Module Replacement (HMR) for a fast, interactive watch mode, allowing tests to re-run almost instantly as you save files. Furthermore, it provides a [Jest](https://jestjs.io/)-compatible API, including familiar [expect](https://jestjs.io/docs/expect#expect) matchers and snapshot testing, making migration from older test runners straightforward while gaining the performance benefits of a modern, ESM-native tool.
