# <img src="https://www.google.com/s2/favicons?sz=128&domain=openai.com" alt="OpenAI logo" align="right" width="96" style="margin-top: 1ex; border-left: 0.1em solid transparent;"> OpenAI Codex CLI

The OpenAI [Codex CLI](https://developers.openai.com/codex/cli) is a tool that allows you to interact with the Codex API directly from your terminal. You can use it to complete code, generate code from natural language descriptions, and more, making it a powerful pair-programming assistant.

- ↪️ Run recipe: `just install-codex`
- To authenticate with your OpenAI account: `codex login`

## Privacy & Opt-out

OpenAI's API and Codex CLI are designed for developers with stricter privacy requirements.

1.  **Opted-out by Default:** As of March 1, 2023, OpenAI **does not use data** submitted via the API (including the Codex CLI) to train its models.
2.  **Data Retention:** Data is retained for 30 days for abuse and misuse monitoring, after which it is deleted.
3.  **Enterprise/Zero Retention:** Organizations with specific security needs can request "Zero Data Retention" for certain endpoints via enterprise agreements.
4.  **Verification:** You can verify your data settings at the [OpenAI API Platform](https://platform.openai.com/account/data-usage).

### Official Resources
- [OpenAI API Data Usage Policies](https://openai.com/policies/api-data-usage-policies) — Official data usage rules for the API.
- [OpenAI Enterprise Privacy](https://openai.com/enterprise-privacy) — Enterprise-grade security and privacy.
- [OpenAI Trust Center](https://trust.openai.com) — Compliance documentation and audits.
