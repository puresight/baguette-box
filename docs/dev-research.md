# Dev Research

- Node
    - [OXC](https://oxc.rs/docs/guide/introduction.html) is a collection of high-performance tools for JavaScript and TypeScript written in Rust. Oxc is part of VoidZero's vision for a unified, high-performance toolchain for JavaScript. It powers Rolldown (Vite's future bundler) and enables the next generation of ultra-fast development tools that work seamlessly together.
        - Linter: [Oxlint](https://oxc.rs/) for instant linting/fixing
        - Formatter: Oxfmt > Prettier; agents are often set up to run `oxlint --fix` and `tsc` in a loop. They fix their own type errors before you ever see the PR.
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
