# AI

The modern AI stack is a layered system, starting with the [hardware](./ai-hardware.md) that dictates performance. On this foundation run the "brains" of the operation: the Large Language Models, ranging from small local LLM's to really big ones that run in cloud datacenters.
The process of running these [models](./ai-models.md) to process requests & generate responses is known as inference.
[Inference](./ai-inference.md) can be performed in clouds, or on your own machine using an engine like [Ollama](./ollama.md "to download, manage, & run LLM's locally"), a tool for locally managing and executing open-weight models.
To simplify the complexity of using varying models running in assorted environments, an orchestration tool like [Stockyard](./stockyard.md "the LLM control plane — proxy, routing, cost tracking, tracing, guardrails, & middleware") serves as your unified gateway. This lets you seamlessly switch between different models (whether self-hosted or running in a cloud) through a single endpoint on your computer.

## Developer Tools

The AI developer tools you choose are often tied to your [AI subscriptions](./ai-subscriptions.md). The provider-specific tools require an account with that service, and your subscription grants you the credentials or the authentication you need to connect it to their remote models for generative coding & analysis.

- [Aider](./aider.md "writes Git commits for every edit") CLI is [model](./ai-models.md)-agnostic
- Anthropic [Claude Code](./claude-code.md) CLI
- OpenAI [Codex](./openai-codex.md) CLI
- Block [Goose](./goose.md) CLI is [model](./ai-models.md)-agnostic
- Google [Gemini](./gemini.md) CLI
- Google [Antigravity](./antigravity.md) IDE
- _Roo Code_ ([model](./ai-models.md)-agnostic) and _Gemini Code Assist_ extensions in [VS Code](../code/README.md) IDE
