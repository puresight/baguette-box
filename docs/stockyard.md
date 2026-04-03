# Stockyard

[Stockyard](https://stockyard.dev/docs/) is a source-available LLM control plane that acts as a unified gateway for AI model interactions. It provides a single, [OpenAI-compatible API](https://developers.openai.com/api/docs/libraries) endpoint to proxy requests to over 16 different model providers, including hosts for open models. With features like cost tracking, smart routing, request tracing, and security guardrails, it simplifies building and managing complex AI-powered applications. Stockyard is a single, self-hosted binary that gives you a unified control layer for cost, performance, and security across all your model providers.

- ↪️ Run recipe to [install from Github with Mise](https://mise.jdx.dev/dev-tools/backends/github.html): `just install-stockyard`

## Unified Access to Cloud-Hosted Open Models

A primary use case for Stockyard is to provide a consistent interface for using powerful open models [hosted by various cloud providers](./ai-services.md). While tools like [Ollama](./ollama.md) are excellent for running models locally, many developers on lightweight workstations need to access larger, faster models in the cloud. Stockyard bridges this gap.

By acting as a local proxy, Stockyard allows you to configure all your AI development tools to a single endpoint (`http://localhost:4200/v1`). You can then switch between different models and providers—from `openai/gpt-4o` to `groq/llama3-70b-8192`—without reconfiguring each tool. Stockyard handles routing the request to the correct upstream provider, while transparently adding valuable observability and control.

This workflow combines the flexibility of open models with the performance of cloud hosting, all managed through a single, consistent developer experience.

## Key Features

| Feature | Description |
| :--- | :--- |
| **Unified Proxy** | An OpenAI-compatible API that lets you use tools built for OpenAI with any supported model provider. |
| **Smart Routing** | Dynamically route requests to the best model based on cost, latency, or availability. |
| **Cost Management** | A central dashboard to track spending across all providers in real-time. Set budgets and alerts to avoid surprises. |
| **Observability** | Get detailed logs and traces for every request, helping you debug errors and identify performance bottlenecks. |
| **Security Guardrails** | Enforce centralized security policies, including PII redaction, key management, and content filtering. |
| **Middleware** | A library of over 76 modules for caching, retries, fallbacks, and custom request/response transformations. |

## Get Started with Community Edition

The self-hosted community edition is free to use and includes the full proxy, middleware library, and core applications (tracing, audit, prompt studio, etc.). It is limited to 10,000 requests per month (with cost-based routing limited to 100 requests per day). This is generally sufficient for individual developer use.

- **Configure API Keys:** Stockyard uses environment variables to authenticate with upstream model providers. For secure storage, consider using the system Keyring.
    ```sh
    # Set keys for the providers you want to use
    export OPENAI_API_KEY="sk-..."
    export GROQ_API_KEY="gsk_..."
    export ANTHROPIC_API_KEY="sk-ant-..."
    ```

- **Access the Dashboard:** Once running, you can view the management UI in your browser to see logs, track costs, and configure routes. Dashboard URL: `http://localhost/ui`

- **Configure Your Tools:** Point your AI tools to the local Stockyard API endpoint. Stockyard requires no API key for local access; it uses the environment variables you set to authenticate with the cloud providers.
    ```sh
    # Example: Configure Aider to use an open model via Stockyard
    export OPENAI_API_BASE="http://localhost:4200/v1"
    export OPENAI_API_KEY="not-needed" # Stockyard handles upstream auth

    # Now you can use any model Stockyard is configured for e.g.
    aider --model groq/llama3-70b-8192
    ```
