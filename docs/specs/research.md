# Research

Topics Queue for Research

- Node
    - WebAssembly: ActionScript
    - TypeScript (strict mode) + [Effect](https://github.com/Effect-TS/effect) for logic.
        - Effect.ts brings Elm-like features (Type-safe errors, Dependency Injection, Managed Effects) into standard TS. It forces you to handle every error explicitly at the type level. If an API call can fail, the return type is `Effect<Data, ApiError, Requirements>`. You literally cannot ignore the error path.
            - Watch [Video about Effect-TS](https://www.youtube.com/watch?v=MHpf_XMz_aM)
    - Framework: 
        - [Encore.dev](https://encore.dev/articles/build-rest-api-typescript-2026) if doing full-stack
        - Next.js with [Zod/TypeBox](https://javascript-conference.com/architecture-performance/safer-typescript-data-validation-zod-typebox/) for data-handling DSLs.
- Rust
    - WebAssembly: if you want to move closer to the metal but keep a component-based model
        - [Leptos](https://medium.com/@priya.raimagiya/the-5-best-rust-frontend-frameworks-reviewed-for-2026-4694dad8f181) is the mainstream choice for high-performance Wasm apps, using "Signals" (similar to SolidJS) but with Rust’s type guarantees.
        - [Yew](https://medium.com/@priya.raimagiya/the-5-best-rust-frontend-frameworks-reviewed-for-2026-4694dad8f181) alternative
- Database
    - [Drizzle ORM](https://orm.drizzle.team/) is the closest thing to LINQ for TypeScript, giving you type-safe SQL, without the "magic" overhead of Prisma.

## Type-Level Engineering

Instead of manually writing types and then writing validation logic (which get out of sync), use a **Type-First** approach.

[TypeBox](https://betterstack.com/community/guides/scaling-nodejs/typebox-vs-zod/): While Zod is more popular, TypeBox is the "high-performance" mainstream choice in 2026. It is built for high-speed JIT validation.

You define your data schema *once*, and it generates both the TypeScript types and the high-speed JSON validator. It bridges the gap between your "Domain Logic" and "Wire Data" instantly.

## misc

- [Tailscale](https://tailscale.com/) used to create a secure, private mesh network (a "tailnet") that connects devs devices, servers, and cloud instances as if they were on the same local Wi-Fi, regardless of their actual physical location.
  - Accessing Private Resources without Port Forwarding: Developers use Tailscale to access internal databases (e.g., PostgreSQL, MySQL), staging environments, or **NAS devices** from anywhere without exposing them to the public internet or fiddling with complex firewall/NAT settings.
  - Secure **Remote Development**: It enables connecting a local IDE (like VS Code) to a high-powered remote server or VM, allowing developers to code on a "thin" laptop while leveraging remote hardware.
  - **CI/CD** Pipeline Connectivity: It securely connects CI/CD runners (like GitHub Actions) to internal test databases or private registries that are otherwise hidden behind a firewall.
  - Collaborative Previews (**Tailscale Funnel**): Developers use Tailscale Funnel to temporarily expose a local web server to the public internet, making it easy to share a work-in-progress feature with a client or teammate.
  - **Tailscale SSH** replaces traditional SSH key management by using the developer's existing identity provider (e.g., GitHub, Google, Okta) to authenticate shell access, including features like session recording for compliance.
  - Testing and Localization: By using "exit nodes," developers can route their traffic through a server in a different geographic region to test how their application behaves in different countries.
- [Neon](https://neon.com/) is a serverless, open-source PostgreSQL database platform designed to eliminate the friction of traditional database management.
- [Chezmoi](https://www.chezmoi.io/user-guide/encryption/age/) is a specialized tool for managing "dotfiles" (config files) across multiple machines. For developers who want to sync personalized shell, editor (VS Code/Zed), and tool settings without the overhead of a full configuration management suite. One Go binary, easy secrets, uses templates.
