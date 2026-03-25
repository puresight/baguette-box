# Kotlin

- [Installed using Mise](https://mise.jdx.dev/lang/kotlin.html)

[Kotlin](https://kotlinlang.org/) is a modern, statically typed programming language developed by JetBrains. It is designed to be fully interoperable with [Java](./java.md) and runs on the Java Virtual Machine (JVM), making it a popular and pragmatic choice for modern application development. Kotlin's syntax is more concise than Java's, significantly reducing boilerplate code. Its key features include built-in **null safety** to prevent null pointer exceptions, first-class support for **coroutines** to simplify asynchronous programming, and strong functional programming capabilities. While it is the official language for Android mobile app development, Kotlin is also widely used for server-side applications, web front-ends (via Kotlin/JS), and cross-platform mobile development with Kotlin Multiplatform (KMP).

## Kotlin Multiplatform

Kotlin Multiplatform is a technology from [JetBrains](https://www.jetbrains.com/) that allows developers to share code across different platforms. Its core strength is sharing non-UI code like business logic, data layers, and networking between native applications.

- [Mobile](./dev-mobile.md#kotlin-multiplatform-kmp): Share logic between native [Android](https://developer.android.com/) & [iOS](https://developer.apple.com/ios/) apps
- [Desktop](./dev-desktop.md#kotlin-multiplatform): Share logic between Windows, macOS, and Linux apps
- [Web](./dev-web.md#kotlin-multiplatform): Share logic for progressive web apps that run in web browsers on both desktop and mobile platforms

Use [Compose Multiplatform](https://www.jetbrains.com/lp/compose-multiplatform/) to build and share UI code across desktop, web, and mobile from a single Kotlin codebase.
