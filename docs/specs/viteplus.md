# VitePlus

[VitePlus](https://viteplus.dev/)

- [VS Code integration](https://viteplus.dev/guide/ide-integration): VitePlus has settings that `vp create` and `vp migrate` can automatically write into the project.
    - extension pack: `VoidZero.vite-plus-extension-pack`
    - url: https://marketplace.visualstudio.com/items?itemName=VoidZero.vite-plus-extension-pack
    - Replaces Prettier for format
- `vp check` (Lint + Format + Type-check) is the default command for fast static checks in Vite+. It brings together formatting through [Oxfmt](https://oxc.rs/docs/guide/usage/formatter.html), linting through [Oxlint](https://oxc.rs/docs/guide/usage/linter.html), and TypeScript type checks through [tsgolint](https://oxc.rs/docs/guide/usage/linter/type-aware.html).
- `vp test` is built on [Vitest](https://vitest.dev/) so you get a Vite-native test runner that reuses your Vite config and plugins, supports Jest-style expectations, snapshots, and coverage, and handles modern ESM, TypeScript, and JSX projects cleanly.

## Notes

- Do not use mise to install VitePlus
- Do not use mise to install Node
-  `~/.vite-plus` for its managed runtimes, cached binaries, and global settings
- `vp env on` configures your shell to use Vite+ shims for node, npm, and pnpm globally. This ensures that even when you aren't in a project folder, you are using a consistent, Vite+-managed version of Node.js. 
- You can set a global fallback with `vp env default lts` but override it for a specific project using `vp env pin 22`
- _Vite Task_ (Recommended for Projects): Define the _Gemini CLI_ as a Task in your `vite.config.ts` if you use it for a specific project: this allows you to run `vp run gemini`. It also benefits from Vite+'s built-in task caching and dependency awareness.
- Commands:
    `vp env on`	        Ensures Vite+ is in control of your node/npm shims
    `vp env install`	Manually pulls the Node version defined in your project config
    `vp env pin <ver>`	Creates a `.node-version` file to lock your project/repo to a specific version
    `vp env use <ver>`	Temporarily switches your current terminal session to a different version
- Formatter: Oxfmt > Prettier; agents are often set up to run `oxlint --fix` and `tsc` in a loop. They fix their own type errors before you ever see the PR.

## VS Code Config

`.vscode/extensions.json`

```json
{
  "recommendations": ["VoidZero.vite-plus-extension-pack"]
}
```

`.vscode/settings.json`

```json
{
  "editor.defaultFormatter": "oxc.oxc-vscode",
  "oxc.fmt.configPath": "./vite.config.ts",
  "editor.formatOnSave": true,
  "editor.formatOnSaveMode": "file",
  "editor.codeActionsOnSave": {
    "source.fixAll.oxc": "explicit"
  }
```

## Example Installation

```sh
#!/bin/bash

# 1. Install Vite+ (vp) toolchain
# This manages the Node.js runtime and package manager shims
echo "Installing Vite+..."
curl -fsSL https://vite.plus | bash

# Refresh shell to recognize 'vp' immediately
export PATH="$HOME/.vite-plus/bin:$PATH"

# 2. Initialize managed environment
# This ensures 'node', 'npm', and 'pnpm' shims point to Vite+ managed versions
vp env on

# 3. Set a global default Node.js version if one isn't active
# Gemini CLI requires Node.js 18+; we'll use the latest LTS
echo "Setting up Node.js (LTS)..."
vp env default lts
vp env install

# 4. Install Gemini CLI globally using the Vite+-managed package manager
# Vite+ will automatically detect the best manager (pnpm/npm) and link the binary
echo "Installing Gemini CLI..."
vp install -g @google/gemini-cli

echo "------------------------------------------------"
echo "Installation complete!"
echo "Run 'gemini' to start, or 'vp help' to explore Vite+."
echo "Note: You may need to restart your terminal for all PATH changes to take effect."

```
