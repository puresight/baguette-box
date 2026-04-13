# <figure style="float: right; margin: 0.5ex 0.5em; line-height: 1; text-align: center; font-size: 80px">💬</figure> AI Inference

For production applications, the standard billing model is pay-as-you-go token metering, where costs scale directly with API usage. Unlike the fixed-cost [monthly subscriptions](./ai-subscriptions.md) favored by app & media developers, this approach provides maximum flexibility for applications with variable workloads. However, it places the technical burden on the developer to optimize for efficiency to control costs. On this page, we explore the ecosystem of providers specializing in token-metered inference, from large-scale cloud platforms to low-latency edge networks.

When choosing between cloud-hosted and local inference, the primary decision factor is your [hardware](./ai-hardware.md) — specifically available VRAM. Use [llmfit](./llmfit.md) to understand what can run on your machine before committing to a local-only or cloud-hybrid strategy.

## LLM Inference Specialists

As we move through 2026, the dominance of "black box" proprietary models has significantly receded, making way for a vibrant, decentralized era defined by open-weights _Mixture-of-Experts (MoE)_ architectures. However, the true democratization of these [models](./ai-models.md) hasn't occurred on local workstations, but through the rise of specialized open-source AI cloud hosting providers. These platforms—ranging from _community-driven hubs_ like [Hugging Face](https://huggingface.co/) to inference-speed innovators like Groq, Together AI, and Fireworks AI—serve as the critical bridge between raw model weights and production-ready applications. By abstracting away the brutal complexities of _GPU orchestration, high-bandwidth memory (HBM) management, and cold-start optimization,_ these providers allow developers to treat state-of-the-art intelligence as a scalable utility rather than a prohibitive infrastructure hurdle.

- [GCP Vertex](https://cloud.google.com/vertex-ai/docs/model-garden/discover-models) is Google Cloud's platform to discover, customize, and deploy foundation [models](./ai-models.md) including a wide array of open-source options.
- [Azure AI Studio](https://azure.microsoft.com/en-us/products/ai-studio) is Microsoft's platform that includes a model catalog with open-source [models](./ai-models.md).
- [AWS Bedrock](https://aws.amazon.com/bedrock/) is Amazon's fully managed service offering foundation models from leading AI companies (including open [models](./ai-models.md)) via a single API.
- [Cloudflare Workers AI](https://www.cloudflare.com/developer-platform/products/workers-ai/) has the CDN/edge first-mover advantage.
- [DeepInfra](https://deepinfra.com/pricing) has the best price-to-performance.
- [Fireworks.ai](https://fireworks.ai/models?featured=true) is a pro all-rounder
- [SiliconFlow](https://www.siliconflow.com/models) has optimized quantization (FP8/INT4) for runing bigger models at speeds of smaller.
- [Groq](https://groq.com/pricing) has speed (LPU technology) for agents.
- [Together AI](https://www.together.ai/models) has fast new model versions with a good variety.
- [Nebius AI](https://nebius.com/token-factory/prices) serves Europe.

Selecting a cloud hosting provider is no longer a simple race to the bottom on per-token pricing, but a strategic alignment with the specific requirements of your AI architecture. The market has bifurcated into specialized niches: those who prioritize the raw, sub-millisecond throughput of custom LPU hardware, those who offer the deepest model catalogs and fine-tuning flexibility, and enterprise-grade players like SiliconFlow that focus on sovereign, compliance-heavy private clouds. As agentic workflows and real-time multimodal systems become the standard, the competitive edge has shifted toward the "inference stack"—the proprietary software layers that optimize how [models](./ai-models.md) actually run on silicon. In this landscape, your hosting partner is far more than a utility vendor; they are the high-performance engine room that determines the latency, reliability, and ultimate viability of your AI strategy.

## Inference on the Edge

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
