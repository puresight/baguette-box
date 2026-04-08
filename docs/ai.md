# AI

The modern AI stack is a layered system, starting with the [hardware](./ai-hardware.md) that dictates performance.
On this foundation run the "brains" of the operation: the [AI models](./ai-models.md) themselves, ranging from small local LLM's to really big ones that run in cloud datacenters.
The process of running these models to process requests & generate responses is known as [inference](./ai-inference.md).
Inference can be performed in clouds, or on your own machine using an engine like [Ollama](./ollama.md "to download, manage, & run LLM's locally"), a tool for locally managing and executing open-weight models.
To simplify the complexity of using varying models running in assorted environments, an orchestration tool like [Stockyard](./stockyard.md "the LLM control plane — proxy, routing, cost tracking, tracing, guardrails, & middleware") serves as your unified gateway. This lets you seamlessly switch between different models (whether self-hosted or running in a cloud) through a single endpoint on your computer.

## Developer Tools

- [Google Antigravity](https://antigravity.google/docs/home "Be an architect/manager of agents") IDE
- _Gemini Code Assist_ and _Roo Code_ in [VS Code](../code/README.md) IDE
- _Gemini CLI_ via [Vite+](./viteplus.md)
- Block's [Goose](https://block.github.io/goose/docs/category/guides "Agentic system designed to automate complex development tasks from start to finish") CLI
- [Aider](./aider.md "writes Git commits for every edit") CLI via [Homebrew](../homebrew/README.md)
