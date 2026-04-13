# <figure style="float: right; margin: 0.5ex 0.5em; line-height: 1; text-align: center; font-size: 80px">🐰</figure> AI Quickstart

Welcome, explorer. Choose a path to equipping yourself with AI assistance. Whether you prefer a completely offline local setup, a high-performance cloud-hybrid architecture, or a managed ecosystem, these examples could give you ideas on how to get started.

## 1. The Beginner (in Google ecosystem)

**Goal:** A seamless, managed experience using Google's AI stack. Perfect if you have a Google [AI subscription](./ai-subscriptions.md).

1.  **IDE Start:** Install [VS Code](../code/README.md) (`just code`) and configure the **Gemini Code Assist** extension for AI-powered autocomplete and chat directly in your editor.
2.  **CLI Graduation:** Run `just install-gemini` to install the [Gemini CLI](./gemini-cli.md). This moves you from simple editor chat to terminal-based agentic workflows that can execute shell commands and fetch web docs.
    ```sh
    gemini  # Authenticate and start chatting
    ```
3.  **Agent Orchestration:** Use [Antigravity](./antigravity.md) (`just install-apt-packages` to get the repo) to begin architecting multi-agent systems and managing autonomous AI workflows at scale.

## 2. An Editor + Terminal Flow (in Anthropic ecosystem)

**Goal:** A high-productivity "Sidecar" workflow. You use the IDE for visibility and control while the terminal-based agent does the heavy lifting. Perfect for split-screen or multi-monitor setups.

1.  **IDE Setup:** Install [VS Code](../code/README.md) (`just code`). Open your project and keep the Source Control and File Explorer sidebars visible to monitor changes.
2.  **CLI Agent:** Run `just install-claude-code` to install the [Claude Code CLI](./claude-code.md). Launch it in VS Code's integrated terminal (`Ctrl+``) or on a second monitor to start agentic tasks.
    ```sh
    claude-code login  # Authenticate
    claude-code        # Start agentic tasks in your current project
    ```
3.  **The Feedback Loop:**
    - **Execute:** Give Claude broad or focused directives in the terminal (e.g., "Refactor the authentication logic to use JWT" or "Fix all linting errors in the 'src/lib' folder").
    - **Evaluate:** Watch the IDE's file explorer and editor tabs as Claude works. Use VS Code's built-in diff viewer to inspect changes in real-time.
    - **Stage & Commit:** Review the modifications in the IDE's Source Control view. Stage only the changes you approve and commit them manually, ensuring you maintain ultimate control over the codebase.

## 3. The Localist (independent)

**Goal:** Complete privacy and zero latency costs. You want your AI [models](./ai-models.md) to run entirely on your own [hardware](./ai-hardware.md).

1.  **Assess:** Run `just install-llmfit` then execute `llmfit` to see which models fit your VRAM.
2.  **Server:** Run `just install-ollama` to install the [Ollama](./ollama.md) inference engine.
3.  **Download:** Pull a recommended model from your `llmfit` results (e.g., `ollama pull qwen3.5:4b`).
4.  **Assistant:** Use [Aider](./aider.md) as your pair programmer.
    ```sh
    # Install Aider via Homebrew
    just install-homebrew-packages
    # Start Aider using your local model
    aider --model ollama/qwen3.5:4b
    ```

## 4. The Power User (in multiple ecosystems)

**Goal:** Maximum intelligence and speed. You want to use cloud-hosted models across multiple providers with unified tracking.

1.  **Gateway:** Run `just install-stockyard` to install the [Stockyard](./stockyard.md) LLM control plane.
2.  **Configure:** Set your API keys as environment variables (OpenAI, Anthropic, Groq, etc.).
3.  **Orchestrate:** Start Stockyard to provide a unified OpenAI-compatible endpoint at `http://localhost:4200/v1`.
4.  **Execute:** Use [Goose](./goose.md) for autonomous agentic tasks or [Aider](./aider.md) for pair programming, both pointed at your Stockyard gateway.
## Privacy & IP Protection

A common concern when using AI assistants is the protection of intellectual property (IP) and trade secrets. Most modern AI providers use "inference-time" data to improve their models unless you explicitly opt out.

- **Local First:** If your security requirements are absolute, follow **The Localist** path. Running models entirely on your own hardware (via Ollama) ensures no data ever leaves your machine.
- **Cloud Opt-Out:** If you use cloud-hosted models, ensure you have configured your accounts to prevent your queries and code from being used for training.

See the specific tool pages for detailed opt-out instructions:
- [Claude Code](./claude-code.md#privacy--opt-out)
- [Gemini CLI](./gemini-cli.md#privacy--opt-out)
- [OpenAI Codex CLI](./openai-codex.md#privacy--opt-out)
