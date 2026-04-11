# <img src="https://www.vectorlogo.zone/logos/scala-lang/scala-lang-icon.svg" alt="Scala logo" align="right" style="max-width: 96px; margin: 0 1em 0 -14px; border-left: 0.1em solid transparent;"> Scala

> [Scala](https://www.scala-lang.org/) is a high-level, statically typed programming language that unifies **object-oriented and functional programming** into one concise and logical syntax. It runs on the Java Virtual Machine (JVM), providing seamless interoperability with existing [Java](./java.md) libraries and ecosystems. Scala is renowned for its powerful type system, which helps prevent bugs in complex applications, and its support for **immutable data structures** and first-class functions makes it ideal for building concurrent and distributed systems. It is widely used in big data processing with frameworks like **Apache Spark** and for creating scalable, resilient backend services with the **Akka** toolkit.

- ↪️ Run recipe to [install with Mise](https://mise.jdx.dev/registry.html?filter=scala#tools): `just install-scala`

## Versions

- Prefer Scala 3 series for new projects
- For production, pick the latest patch release in the recommended series (e.g., 3.5.x for JDK 25, latest 3.x for JDK 21, or 2.13.12+/3.x for JDK 17)

### OpenJDK Match-Ups

- OpenJDK 25 — Scala 3.5+
- OpenJDK 21 — Scala 3.2 – 3.5
- OpenJDK 17 — Scala 2.13.x or Scala 3.0 – 3.4

### Gradle Match-Ups

Gradle core is JVM-version-agnostic, but Scala tooling depends on the Gradle Scala plugin or third-party plugins. For Scala 3 projects, many teams use `sbt`, `Mill`, or `scala-cli` for compilation, and then use Gradle only for Android or native build orchestration.

- Gradle 8.x — supports Java 17+ toolchains; use Scala 2.13.x or Scala 3.x (prefer Scala 3.2+ for best JVM compatibility). Official Gradle scala plugin hasn’t had first-class Scala 3 support; use community plugins or compile with scalac then wire artifacts into Gradle.
- Gradle 7.x — works with Scala 2.12.x and 2.13.x via the built-in scala plugin; can be used with Scala 3 using external plugins (e.g., sbt/scala-cli integration or third‑party Gradle Scala 3 support). Requires Java 11+ for Gradle itself when using recent Gradle releases.
- Gradle 6.x — common with Scala 2.11.x / 2.12.x / 2.13.x (Java 8 toolchain).
