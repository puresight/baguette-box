# Vite+

[Vite+](https://viteplus.dev/) is an integrated, high-performance toolchain for modern web development that streamlines project setup and maintenance. It manages Node.js runtimes and package managers, ensuring consistent environments across projects. By bundling fast, Rust-based tools, it provides a unified interface for static analysis, testing, and task running, aiming to be a comprehensive solution for the software development lifecycle.

Developers should adopt Vite+ to boost productivity and ensure code quality through its unified, performance-oriented architecture. It replaces a fragmented collection of tools like [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#about), [Prettier](https://prettier.io/), and [ESLint](https://eslint.org/), with a single, cohesive command-line interface, reducing configuration overhead. Its integrated version management eliminates environment-related inconsistencies, allowing developers to focus more on building features and less on wrangling tools. It focuses on modernizing existing projects by replacing slow JavaScript tools with fast equivalents; it powers [Vue](https://vuejs.org/), [SvelteKit](https://kit.svelte.dev/), [Nuxt](https://nuxt.com/), [Astro](https://astro.build/), and is gaining ground in [Angular](https://angular.io/). Vite+ is winning the battle for the existing web as most major frameworks have standardized on its architecture.

This performance is also critical for modern agentic ✨AI workflows, where ***fast feedback loops*** from linting and testing enable AI coding assistants to validate their changes and iterate rapidly, significantly accelerating pair programming.

- ↪️ Run recipe `just install-viteplus`
- Config: find its managed runtimes, cached binaries, and global settings in `~/.vite-plus`

## Managing tools 🛠

Vite+ takes control of the **[Node](./node.md)** runtime environment by managing its installation and versioning directly. This eliminates "works on my machine" problems by ensuring that every developer on a project, as well as CI pipelines, use the same version of Node. By abstracting away the need for separate version managers like [mise](./mise.md), Vite+ provides a single, reliable command to set up and maintain the project's foundational runtime, simplifying onboarding and guaranteeing a consistent execution environment.

## Installing packages 📦

In addition to managing the Node.js runtime, Vite+ provides its own integrated package manager. This replaces the need for external tools like [npm](https://docs.npmjs.com/), creating a more cohesive development experience. The package manager is designed for performance, leveraging modern techniques to speed up dependency installation and updates. By handling both the runtime and its packages, Vite+ ensures that the entire dependency graph is consistent and reproducible, further reducing configuration drift and simplifying project maintenance.

## Checking code 🔎

Vite+ streamlines static analysis with the `vp check` command, a high-performance tool that unifies formatting, linting, and type-checking. By leveraging the [Oxc](https://oxc.rs/) toolchain (including Oxfmt, Oxlint, and a TypeScript-aware linter), it provides near-instant feedback.

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

## Editing text 📝

Vite+ deeply integrates with VS Code to provide a zero-config development environment. Upon project setup with `vp create` or `vp migrate`, it automatically generates workspace settings (`.vscode/settings.json`) that enable features like format-on-save. These settings work with the official extensions to provide instant, in-editor feedback from its fast tools. This ensures that code quality and formatting are consistently enforced without requiring developers to manually configure their editor. Because the IDE uses the exact same tools and configuration as the CLI and CI pipeline, you get a consistent, reliable DX.

- [Guide to VS Code IDE integration](https://viteplus.dev/guide/ide-integration)
- Code extension pack: [`VoidZero.vite-plus-extension-pack`](https://marketplace.visualstudio.com/items?itemName=VoidZero.vite-plus-extension-pack)

## Committing changes 🏁

Vite+ includes built-in support for [Git hooks](https://git-scm.com/docs/githooks) (specifically designed to replace external dependencies like [Husky](https://typicode.github.io/husky/) and [lint-staged](https://www.npmjs.com/package/lint-staged)); it integrates hook management directly into the core toolchain using its own CLI commands. When you scaffold a project with `vp create` or use `vp config`, Vite+ automatically installs Git hooks into a `.vite-hooks` directory. Instead of using a separate lint-staged configuration in `package.json`, you define your pre-commit logic directly in your `vite.config.ts` under a staged block.

## Building source 🏭

[Vite](https://vitejs.dev/) is a modern frontend build tool designed for speed and a leaner developer experience. It serves as a fast alternative to older tools like [Webpack](https://webpack.js.org/) by leveraging [native ES modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules) for instant server starts and lightning-fast [Hot Module Replacement](https://webpack.js.org/concepts/hot-module-replacement/ "webpack's HMR docs fyi") ([HMR](https://vitejs.dev/guide/api-hmr.html)).

## Testing functions & features 🧪

Vite+ integrates testing through the `vp test` command, which is powered by [Vitest](https://vitest.dev/). This provides a modern, high-performance testing experience that is deeply integrated with the Vite ecosystem. Unlike traditional test runners like Jest, which require separate and often complex configurations to handle TypeScript and ESM, Vitest reuses your existing Vite configuration out-of-the-box. This eliminates configuration drift and simplifies setup significantly.

The primary advantage is speed and developer experience. Vitest leverages Vite's instant Hot Module Replacement (HMR) for a fast, interactive watch mode, allowing tests to re-run almost instantly as you save files. Furthermore, it provides a [Jest](https://jestjs.io/)-compatible API, including familiar [expect](https://jestjs.io/docs/expect#expect) matchers and snapshot testing, making migration from older test runners straightforward while gaining the performance benefits of a modern, ESM-native tool.

## Running webserver 🕸

Vite+ includes a built-in task runner that serves as a modern alternative to defining scripts in `package.json`. Tasks are defined within the `vite.config.ts` file, allowing you to orchestrate complex workflows, such as running code generators or deployment scripts, directly within your project's configuration. You can execute these tasks using the `vp run <task-name>` command. This integration provides benefits like task caching and dependency awareness, ensuring that tasks only re-run when their inputs have changed, which improves performance and reliability in development and CI/CD pipelines.

## TL;DR 📖

Vite+ is an all-in-one, high-performance toolchain for the modern web. It unifies Node.js version management, packaging, linting, formatting, testing, and task running into a single, cohesive CLI. By leveraging Rust-based tools and a zero-config philosophy, it eliminates tool fatigue and provides a fast, consistent, and productive development experience from local setup to CI/CD pipelines.

| Traditional | Vite+ Equivalent | Tool Function |
| :--- | :--- | :--- |
| [**Webpack**](https://webpack.js.org/) | [**Vite**](https://vitejs.dev/) / [**Rolldown**](https://rolldown.rs/) | Bundles code and assets; handles the build pipeline. |
| [**Prettier**](https://prettier.io/) | [**Oxfmt**](https://oxc.rs/) | Automatically formats code to ensure consistent style. |
| [**ESLint**](https://eslint.org/) | [**Oxlint**](https://oxc.rs/) | Analyzes code to find and fix problems (linting). |
| [**Jest**](https://jestjs.io/) | [**Vitest**](https://vitest.dev/) | Runs unit and integration tests. |
| [**npm**](https://docs.npmjs.com/)/[**yarn**](https://yarnpkg.com/) | [**Vite+**](https://viteplus.dev/) (Built-in) | Manages project dependencies and packages. |
| [**nvm**](https://github.com/nvm-sh/nvm) | [**Vite+**](https://viteplus.dev/) (Built-in) | Provides the Node.js runtime, removing the need for external version managers. |
| [**Husky**](https://typicode.github.io/husky/) | [**Vite+**](https://viteplus.dev/) (Workflow) | Manages git hooks and pre-commit checks natively. |
| [**esbuild**](https://esbuild.github.io/) | [**Rolldown**](https://rolldown.rs/) | Handles fast transformation and minification (unified with the bundler). |
| [**Rollup**](https://rollupjs.org/) | [**Rolldown**](https://rolldown.rs/) | Handles production bundling (Vite+ unifies dev and prod under Rolldown). |
| [**ts-node**](https://typestrong.org/ts-node/) | [**Vite+**](https://viteplus.dev/) (Runtime) | Executes TypeScript files directly without manual compilation. |
| npm scripts | [**Vite+**](https://viteplus.dev/) (Task Runner) | Runs project-specific tasks and scripts. |

## Starting fresh 🌱

Scaffold a new web project:

- Write your specification (specs come first!). Decide on a suitable name for your project. Decide which web application framework and programming language it will use. Pick the latest LTS release of Node _that is supported by your framework._
- `cd ~/src` to navigate into your source code directory
- `vp create` to begin your interview
  - Name your project: Type your actual repo name `<your-repo-name>`
  - Select your framework: Use arrow keys to select e.g. **React**
  - Select language variant: Choose [TypeScript](./typescript.md)
- `cd <your-repo-name>` to navigate into your new directory
- `vp env pin <version>` to pin the [Node](./node.md) version; this adds a `.node-version` file into the project root
- `vp check` to ensure your linting, formatting, and type-checking are all passing
- `vp install` to use a package manager to install your dependencies (defaulting to [pnpm](https://pnpm.io/))
- `vp install -D @google/gemini-cli` to add the Gemini AI assistant as a development dependency
- `vp dev` to launch the Vite development web server
- `http://localhost:5173` in your browser to see it running
- `vp check` again
- Remove the default boilerplate to start with a clean slate
  - Delete `src/App.css` and `src/index.css`
  - Clear out the default code in `src/App.jsx` and replacing it with a simple  
    `export default function App() { return <h1>Hello World</h1>; }`
  - add a cascading style sheets framework, e.g. [Tailwind CSS](https://tailwindcss.com/)
  - add Vitest testing framework
- `vp check` again (we do this often don't we)
- `git add --all`
- `git commit -m "init"` (it should check again)
- `git push` to your chosen <dfn><abbr title="App Lifecycle Management">ALM</abbr></dfn> platform e.g. Github
