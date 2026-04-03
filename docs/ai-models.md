## AI Models

These are some tiny/smol models that can be used with ~4gb of VRAM.

#### Qwen 3.5

Qwen 3.5 series in 3/2026 was widely considered the best-in-class for small, efficient models on consumer hardware. Alibaba optimized this generation for "agentic" tasks—meaning they are significantly better at following complex logic and writing functional code than the previous 2.5 version.

- `ollama run qwen3.5:2b` is the "speed king." It will feel instantaneous in 4gb. It’s perfect for simple Python scripts, refactoring functions, or explaining logic. Qwen 3.5 2B (2.4 Billion) VRAM Usage: ~1.6GB (4-bit quantization).
- `ollama run qwen3.5:4b` is the "sweet spot" for 4gb. It has a noticeably higher "reasoning ceiling" than the 2B version. It can handle more complex logic puzzles and multi-file code explanations. Qwen 3.5 4B (4.1 Billion) VRAM Usage: ~2.9GB (4-bit quantization).

#### DeepSeek R1 Distill Qwen 1.5B

The New Logic King.
([Artificial Analysis](https://artificialanalysis.ai/models/deepseek-r1-distill-qwen-1-5b))
While R1 was the story of 2025, the early 2026 distillations have become incredibly refined. This 1.5B model uses a "CoT" (Chain of Thought) approach that actually works for troubleshooting.

- `ollama run deepseek-r1:1.5b`

#### Qwen3 Next

The Efficiency Champ.
([Ollama](https://ollama.com/library/qwen3-next))
Alibaba’s Qwen3-Next series (released late 2025/early 2026) uses a new sparse attention mechanism that makes the KV-cache (memory used for long conversations) much smaller.

- 0.6B version: This is a "micro" model. You can run this alongside almost any other workload without noticing a performance hit.
- 1.5B version: Better at following complex instructions than the old Llama 3.2 3B.

- `ollama run qwen3:1.5b`

#### SmolLM2

The Specialist. [Hugging Face](https://huggingface.co/)'s [SmolLM2](https://huggingface.co/collections/HuggingFaceTB/smollm2) remains a 2026 Q1 favorite because of its "purity." It was trained on a meticulously curated dataset (Cosmopedia v2), making it surprisingly articulate and less "robotic" than the larger distilled models. Role: It’s great for "roleplay" or creative writing experiments where you don't want the model to sound like a corporate assistant.

- `ollama run smollm2:1.7b`

#### Google's Gemma

[Google's Gemma](https://ai.google.dev/gemma/docs) 3 is natively multimodal. The 1B version fits into ~800MB of VRAM. It is "blink-and-you-miss-it" fast. The 4B version uses ~3.2GB VRAM; it was arguably the smartest model under 5B parameters when released.

- `ollama run gemma3:1b` (or `4b` if you close your browser tabs)

Gemma 4 is excellent for logic and basic coding. It has a new "Thinking Mode" and native agentic capabilities. Look at the "Effective" (E) variants which are specifically optimized for edge devices and lower-VRAM GPUs. Gemma 4 E2B (2 Billion) will run lightning-fast using roughly 1.4GB–1.8GB of VRAM. Gemma 4 E4B (4 Billion) at 4-bit quantization should use ~2.8GB–3.2GB, so you’ll want to close other VRAM-heavy apps like Chrome.

- `ollama run gemma4:2b`
- `ollama run gemma4:4b`
