# <img src="https://www.vectorlogo.zone/logos/visualstudio_code/visualstudio_code-icon.svg" alt="VS Code logo" align="right" style="max-width: 96px; margin-right: 1em; border: 0.1em solid transparent;"> Code

> Visual Studio Code (VS [Code](https://code.visualstudio.com/)) is a streamlined, open-source code editor developed by Microsoft that has become the industry standard for modern software development. To developers, it represents the perfect middle ground between a simple text editor and a heavy Integrated Development Environment (IDE); it is lightweight and fast, yet incredibly powerful thanks to its massive ecosystem of [extensions](https://marketplace.visualstudio.com/vscode). Its built-in support for debugging, Git control, and "IntelliSense" code completion allows developers to customize their workflow for [almost any programming language](https://code.visualstudio.com/docs/languages/overview), making it an essential, versatile hub for building everything from simple scripts to complex enterprise applications.

- ↪️ Run recipe: `just code`
- ✏️ Put extensions in: [`./code/code.Extensions`](./code.Extensions)

This folder holds all information for installing and configuring VS Code IDE,
including the [`code.Extensions`](./code.Extensions) list of extension dependencies to install e.g.

- [Gemini Code Assist](https://marketplace.visualstudio.com/items?itemName=Google.geminicodeassist) AI
- [Roo Code](https://roocode.com/) AI

Here you will find JSON files with configuration updates
that shall be applied (in a shallow merge)
when the Code IDE is installed or configured, including

- [`argv.json`](./argv.json)
- [`user-settings.json`](./user-settings.json)

## Open Source Components

Because [the core of VS Code is open source](https://github.com/microsoft/vscode?tab=readme-ov-file#readme) you can leverage its robust architecture as a foundation for creating their own custom, branded IDEs. Teams can build specialized tools, like Google's web-based AI development environments or Block's Goose AI toolkit, that come pre-packaged with specific extensions, default settings, and deep integrations for their own platforms. This strategy allows devs to offer a familiar, world-class editing experience while delivering a product uniquely tailored to their ecosystem. Here are five of the largest and most significant components:

- [Monaco Editor](https://microsoft.github.io/monaco-editor/) is the core code editor component that powers the VS Code **user interface**. It handles syntax highlighting, code completion, and the actual text manipulation engine.
- [Electron](https://www.electronjs.org/) is the foundational framework VS Code uses to run as a **cross-platform desktop application**. It combines the [Chromium rendering engine](https://chromium.googlesource.com/chromium/blink/) and [Node.js](../docs/node.md) to allow web technologies (HTML, CSS, JS) to operate in a desktop environment.
- [VS Code Workbench](https://code.visualstudio.com/api/extension-capabilities/extending-workbench) is the primary architectural layer (located in the `vs/workbench` directory) that organizes the **layout:** including the activity bar, sidebars, panels, and editors.
- [VS Code Built-in Extensions](https://marketplace.visualstudio.com/items?itemName=L13RARY.l13-built-in-extensions) is a massive collection of essential open-source components bundled with every install including the TypeScript/JavaScript language service, Node.js debugger, Git integration, etc.
- [Xterm.js](https://xtermjs.org/) is the component responsible for the integrated **terminal**. It uses WebGL rendering to provide a high-performance terminal experience within the editor. 
