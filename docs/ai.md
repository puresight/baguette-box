# AI

The modern AI stack is a layered system, starting with the [hardware](./ai-hardware.md) that dictates performance. On this foundation run the "brains" of the operation: the Large Language Models, ranging from small local LLM's to really big ones that run in cloud datacenters.
The process of running these [models](./ai-models.md) to process requests & generate responses is known as inference.
[Inference](./ai-inference.md) can be performed in clouds, or on your own machine using an engine like [Ollama](./ollama.md "to download, manage, & run LLM's locally"), a tool for locally managing and executing open-weight models.
To simplify the complexity of using varying models running in assorted environments, an orchestration tool like [Stockyard](./stockyard.md "the LLM control plane — proxy, routing, cost tracking, tracing, guardrails, & middleware") serves as your unified gateway. This lets you seamlessly switch between different models (whether self-hosted or running in a cloud) through a single endpoint on your computer.

## Developer Tools

The AI developer tools you choose are often tied to your [AI subscriptions](./ai-subscriptions.md). Provider-specific tools, like the `claude-code` CLI, require an account with that service. In contrast, model-agnostic tools like `Aider` can be configured to use any backend. In this case, your subscription (e.g., ChatGPT Plus or Claude Pro) is what grants you the authentication method needed to connect your tool of choice to a powerful, state-of-the-art model for coding and analysis.

- [Aider](./aider.md "writes Git commits for every edit") CLI
- Anthropic [Claude Code](./claude-code.md) CLI
- OpenAI [Codex](./openai-codex.md) CLI
- Block [Goose](./goose.md) CLI
- Google [Gemini](./gemini.md) CLI
- Google [Antigravity](./antigravity.md) IDE
- _Gemini Code Assist_ and _Roo Code_ extensions in [VS Code](../code/README.md) IDE
