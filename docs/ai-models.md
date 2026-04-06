# AI Models

Large Language Models (LLMs) have evolved from cloud-only curiosities into versatile tools integrated across the software stack. On developer workstations, they function as agentic pair programmers, capable of understanding a local codebase to refactor files and automate commits. For consumer applications, small, efficient models are increasingly run directly on-device to power features like intelligent text completion or photo editing without a network connection. In the cloud, providers leverage Content Delivery Networks (CDN's) to serve low-latency inference at the edge, enabling real-time AI features in web applications with global reach.

## For Software Developers

While pay-as-you-go APIs are ideal for production applications, many developers and small teams opt for monthly subscriptions that provide priority access to the most advanced models for daily coding, research, and prototyping. These services often bundle chat interfaces, higher usage limits, and early access to new features, making them a cost-effective way to integrate cutting-edge AI into the development workflow.

- **[Anthropic](https://www.anthropic.com/):** has their [Claude Pro](https://claude.com/pricing/pro) subscription, giving users priority access to its latest models like _Claude Sonnet_. It's highly regarded for its large context window, strong reasoning, and coding capabilities.
- **[OpenAI](https://openai.com/):** The [ChatGPT Plus](https://chatgpt.com/pricing) subscription is a developer staple, providing access to the flagship GPT-4o model, advanced data analysis, image generation with DALL-E 3, and higher message limits.
- **[Google](https://ai.google/):** The [Google One AI Premium plan](https://one.google.com/about/google-ai-plans/) includes access to [Gemini Advanced](https://gemini.google.com/advanced), which uses its most powerful models for complex tasks. It's deeply integrated into the Google ecosystem.
- **[Microsoft](https://www.microsoft.com/ai):** [GitHub Copilot subscription](https://github.com/features/copilot/plans) integrates AI directly into VS Code etc for autocompletion, refactoring, and in-editor chat.

## For Researchers

- **[Perplexity](https://www.perplexity.ai/):** Its [Pro subscription](https://www.perplexity.ai/help-center/en/articles/11187416-which-perplexity-subscription-plan-is-right-for-you) is tailored for research, combining a powerful conversational AI with real-time web search and the ability to choose from various underlying models (including OpenAI's and Anthropic's), making it excellent for sourcing information and citations.

## For Media Producers

For solopreneurs and small media companies, generative AI has become an indispensable co-producer. These tools automate and enhance every stage of the content pipeline, from brainstorming and scriptwriting to generating visual assets and editing final cuts. This allows creators to produce higher-quality content faster and with smaller teams.

- **Video Generation & Editing:**
  - [Runway](https://runwayml.com/) is a comprehensive suite of AI-powered video tools, including text-to-video (Gen-2), automatic background removal, and motion tracking. Ideal for creating B-roll, special effects, and ad content.
  - [Pika Labs](https://pika.art/) is a direct competitor to Runway, known for producing high-fidelity, cinematic video clips from text or image prompts.
  - [Descript](https://www.descript.com/) is an all-in-one video and podcast editor that treats audio/video like a text document. Its AI features, like "Studio Sound" for audio enhancement and automatic filler-word removal, are game-changers for podcasters and YouTubers.
- **Voice & Audio:**
  - [ElevenLabs](https://elevenlabs.io/) is the industry leader for realistic text-to-speech and voice cloning. It's widely used for creating voiceovers, dubbing content into other languages, and producing audio versions of articles.
- **Image & Graphics:**
  - [Midjourney](https://www.midjourney.com/) is the go-to for generating high-quality, artistic images via Discord prompts. Perfect for creating unique YouTube thumbnails, channel branding, and concept art.
  - [Adobe Firefly](https://www.adobe.com/products/firefly.html) (in Adobe Creative Cloud) allows creators to use generative AI within their existing Photoshop or Premiere Pro workflows. It's trained on commercially safe data, making it a reliable choice for advertising.
- **Scripting & Strategy:**
  - ChatGPT, Claude, and Gemini: These general-purpose models are invaluable for brainstorming video ideas, writing and refining scripts, generating SEO-friendly titles and descriptions, and drafting social media posts to promote content.

## For Cloud Apps on the Edge

In the cloud, providers leverage Content Delivery Networks (CDN's) to serve low-latency inference at the edge, enabling real-time AI features in web applications with global reach.
The major hyperscalers (AWS, Google Cloud, and Azure) have shifted their architecture to compete directly with CDN's by offering "Edge Functions" and "Serverless GPU" services. While Vercel focuses on developer experience and Cloudflare on a massive global network of small points of presence, the hyperscalers leverage their massive GPU "Regional Edges" to handle heavier AI workloads.

- [Cloudflare Workers AI](https://developers.cloudflare.com/workers-ai/)
- [Vercel AI SDK](https://ai-sdk.dev/docs/introduction)
- Amazon
  - [AWS Lambda Edge](https://aws.amazon.com/lambda/edge/): This is the direct competitor to Cloudflare Workers. it allows you to run Node.js or Python code at AWS CloudFront locations globally. In 2026, it is commonly used for AI tasks like request routing, A/B testing models, and prompt sanitization.
- Google
  - [GCP Cloud Functions (2nd Gen)](https://cloud.google.com/blog/products/serverless/cloud-functions-2nd-generation-now-generally-available): Competes with Cloudflare Workers. It uses the same "Min-instances" technology to eliminate cold starts, making it viable for real-time AI API middleware.
- Microsoft Azure
  - [Azure Static Web Apps](https://learn.microsoft.com/en-us/azure/static-web-apps/overview) (SWA): The direct competitor to Vercel for frontend-heavy AI apps. It integrates seamlessly with Azure Functions for back-end AI logic and has built-in "First-class" support for the Azure OpenAI Service.
  - [Azure Functions (Flex Consumption)](https://learn.microsoft.com/en-us/azure/azure-functions/flex-consumption-plan): A 2026 evolution that allows for high-concurrency AI processing. It competes with Cloudflare’s "Dedicated Pools" by providing guaranteed memory and CPU for token-heavy LLM streaming.

## Tiny Open LLM's For Local Development

For developers working on workstations with limited VRAM (e.g., 4gb), running small, open-weight LLMs locally has become a powerful and cost-effective practice. These "tiny" models, often 4 billion parameters or fewer, are optimized to run efficiently on consumer-grade GPUs. They enable a suite of offline-first AI capabilities directly within the development environment, including advanced code completion, in-IDE pair programming for refactoring and debugging, and simple agentic workflows for tasks like generating boilerplate code or writing commit messages.

### Google Gemma

Google's Gemma 3 was natively multimodal. The 1B version fits into ~800MB of VRAM. It is fast. The 4B version uses ~3.2GB VRAM; it was arguably the smartest model under 5B parameters when released. Run `ollama run gemma3:1b` (or `4b` if you close GUI apps).

[Gemma](https://ai.google.dev/gemma/docs) 4 is excellent for logic and basic coding. It has a new thinking mode and native agentic capabilities. The "Effective" (E) variants which are specifically optimized for edge devices and lower-VRAM GPUs.

- `ollama run gemma4:e2b` will run lightning-fast using roughly 1.4GB–1.8GB
- `ollama run gemma4:e4b` at 4-bit quantization should use ~2.8GB–3.2GB _(so you’ll want to close other VRAM-heavy apps like Chrome)_

### Alibaba Qwen

[Alibaba's](https://modelstudio.alibabacloud.com/) [Qwen](https://qwen.ai/)
3.5 series in 3/2026 was widely considered the best-in-class for small, efficient models on consumer hardware. Alibaba optimized this generation for "agentic" tasks—meaning they are significantly better at following complex logic and writing functional code than the previous 2.5 version.

- `ollama run qwen3.5:2b` is the "speed king." It will feel instantaneous in 4gb. It’s perfect for simple Python scripts, refactoring functions, or explaining logic. Qwen 3.5 2B (2.4 Billion) VRAM Usage: ~1.6GB (4-bit quantization).
- `ollama run qwen3.5:4b` is the "sweet spot" for 4gb. It has a noticeably higher "reasoning ceiling" than the 2B version. It can handle more complex logic puzzles and multi-file code explanations. Qwen 3.5 4B (4.1 Billion) VRAM Usage: ~2.9GB (4-bit quantization).

Qwen Next: The Efficiency Champ
([Ollama](https://ollama.com/library/qwen3-next))?
Alibaba’s Qwen3-Next series released 2025q4 used a new sparse attention mechanism that makes the KV-cache (memory used for long conversations) much smaller. Run `ollama run qwen3:1.5b` that is better at following complex instructions than the old Llama 3.2 3B.

### DeepSeek

The Old Logic King
([Artificial Analysis](https://artificialanalysis.ai/models/deepseek-r1-distill-qwen-1-5b)):
While R1 was the story of 2025, the early 2026 distillations have become refined. This 1.5B model uses a "CoT" (Chain of Thought) approach that works for troubleshooting.

- `ollama run deepseek-r1:1.5b`

### Hugging Face

Creative writing or roleplay specialist? Hugging Face's [SmolLM2](https://huggingface.co/collections/HuggingFaceTB/smollm2) remains a 2026 Q1 favorite because of its "purity." It was trained on a meticulously curated dataset ([Cosmopedia](https://huggingface.co/blog/cosmopedia) v2), making it surprisingly articulate and less "robotic" than the larger distilled models. Run `ollama run smollm2:1.7b`
