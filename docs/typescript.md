# <img src="https://www.vectorlogo.zone/logos/typescriptlang/typescriptlang-icon.svg" alt="TypeScript logo" align="right" width="96" style="margin-top: 1ex; border-left: 0.1em solid transparent;"> TypeScript

[Typescript](https://www.typescriptlang.org/docs/)
is a strongly typed superset of [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript) developed and maintained by Microsoft. It builds upon JavaScript by adding **static types**, which act as a safety net to catch errors early during development rather than at runtime. Because it is a superset, any valid JavaScript code is also valid TypeScript code. However, browsers cannot run TypeScript directly; it must be transpiled (converted) into plain JavaScript before execution.

- Use TypeScript in strict mode
- Library: [Effect](https://github.com/Effect-TS/effect) brings Elm-like features (Type-safe errors, Dependency Injection, Managed Effects) into standard TS. It forces you to handle every error explicitly at the type level. If an API call can fail, the return type is `Effect<Data, ApiError, Requirements>`. You literally cannot ignore the error path. Watch [video about Effect-TS](https://www.youtube.com/watch?v=MHpf_XMz_aM).
- Library: [Encore.dev](https://encore.dev/ "Batteries included TypeScript framework
for building distributed systems") [if doing full-stack](https://encore.dev/articles/build-rest-api-typescript-2026)
- ORM: [Drizzle ORM](https://orm.drizzle.team/) is the closest thing to [LINQ](https://learn.microsoft.com/en-us/dotnet/standard/linq/) for TypeScript, giving you type-safe SQL without the "magic" overhead of Prisma.
- Instead of manually writing types and then writing validation logic (which get out of sync), use a **Type-First** approach. [TypeBox](https://betterstack.com/community/guides/scaling-nodejs/typebox-vs-zod/): While Zod is more popular, TypeBox is the "high-performance" mainstream choice in 2026. It is built for high-speed JIT validation. You define your data schema *once*, and it generates both the TypeScript types and the high-speed JSON validator. It bridges the gap between your "Domain Logic" and "Wire Data" instantly.
