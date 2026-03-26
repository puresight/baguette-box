# Ollama

Ollama is a powerful tool that simplifies running and managing large language models (LLMs). While it is well-known for running open-source models like Llama 3 and Mistral locally, it can also act as a unified interface to access powerful cloud-based models. It packages model configurations into a self-contained format called a `Modelfile` and provides a simple command-line interface and a local REST API. This turns your personal computer into a versatile AI development server, regardless of whether the models are running on your hardware or in the cloud.

- ↪️ Recipe to [install with Mise](https://mise.jdx.dev/registry.html?filter=ollama#tools): `just install-ollama`

## Using Cloud Models for AI Tooling

For developers on lightweight workstations without powerful GPUs, running large, capable models locally is often not feasible. Ollama provides a solution by allowing you to "proxy" requests to cloud-based models through its local API. This gives you a consistent, unified endpoint for all your AI tools (like Aider, Goose, or Roo Code), simplifying configuration and allowing you to easily switch between different model providers without reconfiguring each tool.

The process involves creating a local "proxy" model in Ollama that forwards requests to a cloud provider.

1.  **Set the API Key:** The Ollama server needs your cloud provider's API key. You must set it as an environment variable for the `ollama` server process. For example, for OpenAI:
    ```sh
    export OPENAI_API_KEY="sk-..."
    ```
    _Note: If you run Ollama as a systemd service, you may need to edit the service unit file to pass this environment variable to the daemon._
2.  **Create a `Modelfile`:** Create a file named `Modelfile` that specifies the cloud model you want to use.
    ```modelfile
    # This Modelfile will proxy requests to OpenAI's gpt-4o model
    FROM openai/gpt-4o
    ```
3.  **Create the Ollama Model:** Use the `ollama create` command to register this proxy model. Here, we'll name it `gpt-4o-proxy`.
    ```sh
    ollama create gpt-4o-proxy -f Modelfile
    ```
4.  **Configure your AI tool:** Point your tool to the new Ollama model. For example, to use Aider with your proxied GPT-4o model:
    ```sh
    aider --model ollama/gpt-4o-proxy
    ```
This same principle applies to other development assistants and cloud providers (e.g., `FROM google/gemini-1.5-pro`). By configuring your tools to use your local Ollama endpoint, you can leverage powerful cloud models for coding and development, even on a machine without a dedicated GPU.
