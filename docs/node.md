# Node

[Node](https://nodejs.org/docs/latest/api/documentation.html) is an open-source, cross-platform JavaScript runtime environment that allows developers to execute JavaScript code outside of a web browser. Built on Google's [V8](https://v8.dev/) engine, it enables the use of JavaScript for server-side scripting to build fast and scalable network applications. Its core strength lies in its asynchronous, event-driven architecture, which uses a single-threaded event loop to handle thousands of concurrent connections without blocking execution.

[Typescript](https://www.typescriptlang.org/docs/)
is a strongly typed superset of [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) developed and maintained by Microsoft. It builds upon JavaScript by adding **static types**, which act as a safety net to catch errors early during development rather than at runtime. Because it is a superset, any valid JavaScript code is also valid TypeScript code. However, browsers cannot run TypeScript directly; it must be transpiled (converted) into plain JavaScript before execution.

- [Node is installed via Mise.](https://mise.jdx.dev/lang/node.html)
- [npm](https://www.npmjs.com/) (Node Package Manager) is the default package manager for the Node runtime environment

## Development Frameworks

The Node.js ecosystem is rich with frameworks that streamline development for both server-side and client-side applications.

### Server-Side

While Node.js provides the core runtime, frameworks like [Express.js](https://expressjs.com/) have become the de-facto standard for building web servers and APIs. They provide routing, middleware, and templating tools that simplify backend development. (Other popular choices include [Fastify](https://www.fastify.io/) for high performance and [NestJS](https://nestjs.com/) for building scalable, enterprise-grade applications with TypeScript.)

### Client-Side (Frontend)

For building user interfaces, the JS/TypeScript ecosystem offers several powerful component-based frameworks. These tools enable developers to create interactive, single-page applications (SPA's) that run in the browser.

- [React](./dev-web.md#react) is a library for building user interfaces, maintained by Meta. It uses a declarative, component-based approach and is one of the most popular choices for web development.
- [Vue.js](https://vuejs.org/) is an approachable, performant, and versatile framework for building web user interfaces. It is known for its gentle learning curve.
- [Svelte](https://svelte.dev/) is a radical new approach to building user interfaces. Whereas traditional frameworks do their work in the browser, Svelte shifts that work into a compile step that happens when you build your app.

## Workstation Applications

- [Gemini CLI](https://geminicli.com/docs/) is a conversational assistant that can reason through complex requests and execute multi-step workflows; it uses Google's Gemini models in your terminal. It acts as a pair programmer to write, debug, and refactor code using a Reason & Act (Re/Act) loop. Has built-in tools for file system interaction, shell command execution, and web fetching. Uses large context windows to analyze codebase. Supports MCP. Has "slash commands" (e.g., /chat, /auth). `npm install -g @google/gemini-cli`
