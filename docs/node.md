# Node

[Node.js](https://nodejs.org/docs/latest/api/documentation.html) is an open-source, cross-platform JavaScript runtime environment that allows developers to execute JavaScript code outside of a web browser. Built on Google's [V8](https://v8.dev/) engine, it enables the use of JavaScript for server-side scripting to build fast and scalable network applications. Its core strength lies in its asynchronous, event-driven architecture, which uses a single-threaded event loop to handle thousands of concurrent connections without blocking execution.

[Typescript](https://www.typescriptlang.org/docs/)
is a strongly typed superset of [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) developed and maintained by Microsoft. It builds upon JavaScript by adding **static types**, which act as a safety net to catch errors early during development rather than at runtime. Because it is a superset, any valid JavaScript code is also valid TypeScript code. However, browsers cannot run TypeScript directly; it must be transpiled (converted) into plain JavaScript before execution.

- [Node is installed via Mise.](https://mise.jdx.dev/lang/node.html)
- [npm](https://www.npmjs.com/) (Node Package Manager) is the default package manager for the Node runtime environment

## Applications

[Gemini CLI](https://github.com/google-gemini/gemini-cli?tab=readme-ov-file#gemini-cli) is a conversational assistant that can reason through complex requests and execute multi-step workflows; it uses Google's Gemini models in your terminal. It acts as a pair programmer to write, debug, and refactor code using a Reason & Act (Re/Act) loop. Has built-in tools for file system interaction, shell command execution, and web fetching. Uses large context windows to analyze codebase. Supports MCP. Has "slash commands" (e.g., /chat, /auth). `npm install -g @google/gemini-cli`
