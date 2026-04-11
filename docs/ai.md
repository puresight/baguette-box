# AI

The modern AI stack is a layered system, starting with the [hardware](./ai-hardware.md) that dictates performance. Before selecting your stack, use [llmfit](./llmfit.md) to determine what your local machine can realistically handle. On this foundation run the "brains" of the operation: the Large Language Models, ranging from small local LLM's to really big ones that run in cloud datacenters.

The process of running these [models](./ai-models.md) to process requests & generate responses is known as inference. [Inference](./ai-inference.md) can be performed in clouds, or on your own machine using an engine like [Ollama](./ollama.md "to download, manage, & run LLM's locally").

To simplify the complexity of using varying models running in assorted environments, we recommend an orchestration tool like [Stockyard](./stockyard.md "the LLM control plane — proxy, routing, cost tracking, tracing, guardrails, & middleware") as your unified gateway. It serves as a single, OpenAI-compatible endpoint on your computer, allowing you to manage costs and switch providers without reconfiguring your tools.

## Developer Tools

The AI developer tools you choose are often tied to your [AI subscriptions](./ai-subscriptions.md). The provider-specific tools require an account with that service, and your subscription grants you the credentials or the authentication you need to connect it to their remote models for generative coding & analysis.

- [Aider](./aider.md "writes Git commits for every edit") CLI is [model](./ai-models.md)-agnostic
- Anthropic [Claude Code](./claude-code.md) CLI
- OpenAI [Codex](./openai-codex.md) CLI
- Block [Goose](./goose.md) CLI is [model](./ai-models.md)-agnostic
- Google [Gemini](./gemini.md) CLI
- Google [Antigravity](./antigravity.md) IDE
- _Roo Code_ ([model](./ai-models.md)-agnostic) and _Gemini Code Assist_ extensions in [VS Code](../code/README.md) IDE

If you're new using AI, check out our [quickstart](./ai-quickstart.md) to discover a path for pairing with AI.

## Agentic Workflows

An **Agentic Workflow** is a development pattern where the AI doesn't just "chat," but is empowered to use tools, execute code, and perform multi-step reasoning to achieve a goal. This project is built to enable you to use "Agentic AI" — moving beyond simple prompt-response into a loop where the agent has access to your terminal & codebase, consisting of steps like:

- **Research:** Perceive & observe: gather data from environment, users, metrics.
- **Strategy:** Interpret & model: synthesize observations into beliefs, state, goals, and hypotheses.
- **Plan:** Choose objectives, create plans, allocate resources and roles.
- **Act:** Execute tasks, run migration, deploy changes, produce outcomes.
- **Evaluate:** Measure results, collect feedback, detect errors and opportunities.
- **Learn:** Update models, rules, priorities, and policies; incorporate lessons into next cycle.

### Agent Skills & Roles

[Agent Skills](./ai-skills.md) are folders of instructions and resources that teach agents how to complete specific tasks related to a role more accurately & efficiently.
