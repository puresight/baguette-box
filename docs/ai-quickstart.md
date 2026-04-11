# AI Quickstart

Welcome, explorer. Choose a path to equipping yourself with AI assistance. Whether you prefer a completely offline local setup, a high-performance cloud-hybrid architecture, or a managed ecosystem, these examples could give you ideas on how to get started.

## 1. The Beginner (Google Ecosystem)

**Goal:** A seamless, managed experience using Google's AI stack. Perfect if you have a Google [AI subscription](./ai-subscriptions.md).

1.  **IDE Start:** Install [VS Code](../code/README.md) (`just code`) and configure the **Gemini Code Assist** extension for AI-powered autocomplete and chat directly in your editor.
2.  **CLI Graduation:** Run `just install-gemini` to install the [Gemini CLI](./gemini.md). This moves you from simple editor chat to terminal-based agentic workflows that can execute shell commands and fetch web docs.
    ```sh
    # Authenticate and start chatting
    gemini
    ```
3.  **Agent Orchestration:** Use [Antigravity](./antigravity.md) (`just install-apt-packages` to get the repo) to begin architecting multi-agent systems and managing autonomous AI workflows at scale.

## 2. The Localist

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

## 3. The Power User

**Goal:** Maximum intelligence and speed. You want to use cloud-hosted models across multiple providers with unified tracking.

1.  **Gateway:** Run `just install-stockyard` to install the [Stockyard](./stockyard.md) LLM control plane.
2.  **Configure:** Set your API keys as environment variables (OpenAI, Anthropic, Groq, etc.).
3.  **Orchestrate:** Start Stockyard to provide a unified OpenAI-compatible endpoint at `http://localhost:4200/v1`.
4.  **Execute:** Use [Goose](./goose.md) for autonomous agentic tasks or [Aider](./aider.md) for pair programming, both pointed at your Stockyard gateway.
    ```sh
    # Example: Running Aider through Stockyard
    export OPENAI_API_BASE="http://localhost:4200/v1"
    aider --model anthropic/claude-3-5-sonnet
    ```
