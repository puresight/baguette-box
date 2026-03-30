# VitePlus

## Notes

- Recommended for Projects: a Vite Task: Define the _Gemini CLI_ as a Task in your `vite.config.ts` if you use it for a specific project: this allows you to run `vp run gemini`. It also benefits from Vite+'s built-in task caching and dependency awareness.
- Command `vp env use <ver>`	Temporarily switches your current shell session to a different version of node
- Agents are often set up to run `oxlint --fix` and `tsc` in a loop. They fix their own type errors before you ever see the PR.

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
