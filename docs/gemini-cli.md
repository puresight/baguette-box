# <img src="https://cdn.simpleicons.org/googlegemini" alt="Google Gemini logo" align="right" width="96" style="margin-top: 1ex; border-left: 0.1em solid transparent;"> Gemini CLI

The [Gemini CLI](https://geminicli.com/docs/) is a conversational AI assistant that runs in your terminal, leveraging Google's [Gemini models](https://ai.google.dev/gemini-api/docs/models) to reason through complex requests, execute multi-step workflows, and interact with your local file system. With built-in tools for shell command execution and web fetching, it can write, debug, and refactor code by analyzing your codebase within its large context window.

- ↪️ Run recipe: `just install-gemini`
- [Command reference](https://geminicli.com/docs/reference/commands/)

## Settings & Instructions

- Cascading configuration of `.gemini/settings.json` files; deeper directory settings override
- Instructions in `GEMINI.md` files concatenate as you go deeper in directories

## Models

- `gemini-2.5-flash`has standard balance of speed and intelligence
- `gemini-2.5-pro` **(0.8x cost)** has high stability for production engineering
- `gemini-3.1-flash-lite-preview` **(0.2x cost)** is the _fastest_ "smart" model; replaced 2.5-flash-lite
- `gemini-3-flash-preview` **(1.0x cost)** has near-pro _logic_ but significantly _faster_ and lower latency
- `gemini-3.1-pro-preview` **(5.0x cost)** has deepest reasoning, for multi-step agentic tasks
- `gemini-3.1-pro-preview-customtools` was optimized for complex shell & custom _tool calls_
- `gemini-3-deep-think` is a variant of the Pro model that utilizes a dedicated "Deep Think" mode for math or extremely logic-dense coding problems
- 🏷 `gemini-pro-latest` **alias** currently points to gemini-3.1-pro-preview.
- 🏷 `gemini-flash-latest` **alias** currently pointing to gemini-3-flash-preview.
- `gemini-3.1-flash-live-preview` is the latest _audio-to-audio_ model, though less relevant for a terminal CLI unless you are using the Live API features.
- `gemini-3-pro-image-preview` aka _Nano Banana Pro_ isn't typically in the Gemini CLI but is accessible if you use its specific string identifier. Don't let the name fool you! While optimized for "Image Reasoning," this model has a significantly higher instruction-adherence score for layout and formatting. If you are writing a technical manual that requires complex Markdown tables, Mermaid diagrams, or specific SVG layouts, this version of the Pro model is superior at "visualizing" the document structure as it writes.
- The _Gemini 3.1 Ultra_ model is only available through the _GCP Vertex AI API_ or the _Gemini Web UI._ This is Google's "Frontier" creative model. If you are writing high-stakes persuasive business proposals or deep-dive research papers, the Ultra tier outperforms the Pro series in creative flair and complex narrative coherence.

## Privacy & Opt-out

Google's data usage policies depend on whether you are using the Gemini API via a free or paid tier.

1.  **Free Tier (Google AI Studio):** Your prompts, responses, and related data **may be used** by Google to improve its models and may be reviewed by human annotators. **Do not submit sensitive or confidential information to the free tier.**
2.  **Paid Tier (Pay-as-you-go):** To opt out of data training, you must enable billing for your project in Google AI Studio. **Paid services do not use your content for model training.**
3.  **Vertex AI:** Using Gemini via Google Cloud's Vertex AI provides enterprise-grade privacy by default, where data is never used for training foundation models.

### Official Resources
- [Google AI Studio Data Logging](https://ai.google.dev/gemini-api/docs/data-logging) — How data is handled in AI Studio.
- [Gemini API Terms of Service](https://ai.google.dev/terms) — Legal terms for free and paid tiers.
- [Vertex AI Data Privacy](https://cloud.google.com/vertex-ai/docs/generative-ai/data-privacy) — Enterprise data protection on Google Cloud.
