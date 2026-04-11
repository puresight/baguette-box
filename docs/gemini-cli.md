# Gemini CLI

The [Gemini CLI](https://geminicli.com/docs/) is a conversational AI assistant that runs in your terminal, leveraging Google's [Gemini models](https://ai.google.dev/gemini-api/docs/models) to reason through complex requests, execute multi-step workflows, and interact with your local file system. With built-in tools for shell command execution and web fetching, it can write, debug, and refactor code by analyzing your codebase within its large context window.

- ↪️ Run recipe: `just install-gemini`
- [Command reference](https://geminicli.com/docs/reference/commands/)

## Settings & Instructions

- Cascading configuration of `.gemini/settings.json` files; deeper directory settings override
- Instructions in `GEMINI.md` files concatenate as you go deeper in directories

## Plethora of Gemini Models

- `gemini-3.1-pro-preview` (5.0x cost) has deepest reasoning, for multi-step agentic tasks
- `gemini-3.1-pro-preview-customtools` was optimized for complex shell & custom _tool calls_
- `gemini-3-flash-preview` (1.0x cost) has near-pro _logic_ but significantly _faster_ and lower latency
- `gemini-3.1-flash-lite-preview` (0.2x cost) is the _fastest_ "smart" model; replaced 2.5-flash-lite
- `gemini-2.5-pro` (0.8x cost) has high stability for production engineering
- `gemini-2.5-flash`has standard balance of speed and intelligence
- `gemini-3-deep-think` is a variant of the Pro model that utilizes a dedicated "Deep Think" mode for math or extremely logic-dense coding problems
- `gemini-3.1-flash-live-preview` is the latest _audio-to-audio_ model, though less relevant for a terminal CLI unless you are using the Live API features.
- `gemini-pro-latest` **alias** currently points to gemini-3.1-pro-preview.
- `gemini-flash-latest` **alias** currently pointing to gemini-3-flash-preview.
