# llmfit

[llmfit](https://github.com/AlexsJones/llmfit) is a command-line utility that helps you determine which open-source Large Language Models (LLMs) can run on your local hardware. It inspects your system's processors, VRAM, RAM, etc and cross-references it with the requirements of models, giving you a clear list of what will "fit" on your machine.

- ↪️ Run recipe to compile & install for your system: `just install-llmfit`

## The Challenge of Local Inference

The open-source AI landscape is moving at a breakneck pace, with new and updated models released weekly. While tools like [Ollama](./ollama.md) make it incredibly easy to download and run these models, a critical question remains: *Will this model actually run on my computer?*

A model's size (e.g., 3B, 8B, 70B parameters) and its quantization level directly impact the VRAM required. Running a model that's too large for your GPU results in "spillover" to system RAM, causing a _dramatic slowdown_ that makes local inference impractical. `llmfit` solves this problem by providing an answer before you spend time downloading a multi-gigabyte model that won't perform well.

## Role in the AI Tooling Ecosystem

`llmfit` acts as a crucial "pre-flight check" in a developer's local AI workflow, integrating seamlessly with other tools:

-   **Ollama:** `llmfit` is the perfect companion to Ollama. Before you run `ollama pull <some-new-model>`, you can run `llmfit` to confirm that the model is a good match for your hardware's capabilities. It takes the guesswork out of model selection.
-   **Stockyard:** While Stockyard provides a unified API to manage both cloud and local models, `llmfit` helps you provision the "local" part of that stack. You can use `llmfit` to identify the most powerful models your workstation can handle, and then configure Stockyard to use them for fast, free, offline tasks. For more demanding queries, Stockyard can then route requests to powerful cloud-based models, giving you the best of both worlds.

## Practical Usage

Using `llmfit` is straightforward. You can have it auto-detect your hardware or specify your resources manually.

1.  **Auto-detect hardware:** Run the command without any flags. `llmfit` will attempt to detect your available VRAM and system RAM.

1.  **Manually specify resources:** If you want to see what would fit on a different machine or simulate a specific configuration, you can provide the VRAM and RAM in gigabytes.
    ```sh
    # Show models that fit within 8GB VRAM and 16GB RAM
    llmfit -vram 8 -ram 16
    ```

The output will be a list of Ollama models that meet your criteria, helping you make an informed decision.

## Automating Model Selection

For power users, `llmfit` can be integrated into automated scripts to keep the local model library fresh. By using the JSON output flag, you can programmatically process the list of compatible models.

```sh
# Get a list of compatible models in JSON format
llmfit recommend --json --limit 5
```

The Mapping Logic: In the resulting JSON array, look for the `best_quant` and `run_mode` fields. If llmfit detects Ollama is running, it often includes an `ollama_tag` or similar field in the model's metadata object (depending on the specific version of the tool).

Provider Filtering with `--runtime` (or `-r`): you can narrow the JSON output to only show models compatible with a specific tool by using the runtime filter; this forces the mapping logic to prioritize that runner's naming convention.

- Ollama: `llmfit --json fit -r ollama`
- llama.cpp: `llmfit --json fit -r llama.cpp`
- MLX: `llmfit --json fit -r mlx`

When you parse the JSON output, the mapping is typically found across these keys:

- `name`: The canonical Hugging Face ID (e.g., meta-llama/Llama-3.1-8B-Instruct).
- `best_quant`: The specific quantization string (e.g., Q4_K_M) required for the runner.
- Internal Tags: Some versions of the JSON schema include a tags array or a provider_id that contains the exact string used for ollama pull or ramalama pull.

Some automation is possible if llmfit supports your inference engine. For example, you could write a shell script that runs on a schedule (e.g., a weekly cron job) to:

1.  Run `llmfit -o json` to get the latest list of compatible models.
1.  Use a tool like `jq` to parse the JSON and extract the names of the top-recommended models.
1.  Pipe these names to `ollama pull` to download them automatically.
1.  Optionally, run `ollama rm` to prune older or unused models.

This workflow turns your workstation into a self-maintaining AI development environment, ensuring you always have the best-performing local models at your fingertips without manual intervention.
