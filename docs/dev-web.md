# Web development

Web development encompasses building websites and software applications for the internet. This guide provides an overview of several modern frameworks used to create rich, interactive user experiences. Below, you'll find introductions to React, a popular JavaScript library, as well as cross-platform toolkits like Flutter and Kotlin Multiplatform that bring different paradigms to web UI development.

## React

[React](https://react.dev/) is a declarative, component-based JavaScript library for building user interfaces, particularly for single-page applications where you need a fast, interactive experience. Maintained by Meta, it allows developers to create reusable UI components that manage their own state, leading to more predictable and debuggable code.

### Get Started

- 📖 **Start with the official tutorial:** The [React Docs](https://react.dev/learn) offer a comprehensive, modern guide to learning React from the ground up.
- ⚙ **Use a modern build tool:** Instead of the legacy `create-react-app`, bootstrap your projects with Vite. It's significantly faster and simpler to configure. Get started with TypeScript:
  ```sh
  npm create vite@latest my-react-app -- --template react-ts
  ```
- 📦 **Understand component state:** Grasping core concepts like component state (`useState`), props, and the component lifecycle is fundamental to building anything non-trivial.

## Flutter

[Flutter](./flutter.md) is a UI toolkit from Google for building natively compiled applications for web, mobile, and desktop from a single codebase. While it's widely known for mobile development, its web support has matured significantly, allowing developers to create rich, hardware-accelerated web applications with complex animations and a consistent look and feel across all platforms. It uses the [Dart](https://dart.dev/) programming language and a reactive, widget-based architecture.

### Get Started

- 📖 **Learn about web support:** Read the official documentation on Flutter for the web to understand its rendering models (HTML vs. CanvasKit) and best practices.
- ⚙ **Enable web support:** If you have Flutter installed, ensure web support is enabled by running `flutter config --enable-web`.
- 🚀 **Create a new project:** Run `flutter create my_flutter_web_app` to generate a new project with web support included. You can then run it in Chrome with `flutter run -d chrome`.
- 📦 **Understand layout constraints:** Unlike traditional web development with HTML/CSS, Flutter uses a widget tree with layout constraints. Familiarize yourself with core layout widgets like `Row`, `Column`, `Container`, and `Expanded`.

## Kotlin Multiplatform

[Compose Multiplatform for Web](https://www.jetbrains.com/lp/compose-multiplatform/web/), an extension of [Kotlin Multiplatform](https://kotlinlang.org/lp/multiplatform/), allows developers to build UIs for web, desktop, and mobile from a single, shared Kotlin codebase. For web development, it leverages [Kotlin/JS](https://kotlinlang.org/docs/js-overview.html) to compile declarative UI code written with the [Jetpack Compose paradigm](https://developer.android.com/jetpack/compose) into interactive web applications. This enables teams to share not only business logic but also the entire user interface, ensuring consistency and accelerating development across platforms.

### Get Started

- 📖 **Explore Compose for Web:** Read the official documentation to understand its capabilities and how it renders to the DOM or a Canvas.
- ⚙ **Use the KMP Wizard:** The easiest way to start is with the Kotlin Multiplatform wizard in IntelliJ IDEA or Android Studio. Select the "Web" target to generate a project with the necessary configuration.
- 🚀 **Learn the Compose Mindset:** If you're new to Compose, learn the fundamentals of declarative UI, including Composable functions, state management, and modifiers. The principles are the same as on Android.
- 📦 **Run your web app:** Once your project is set up, you can run your web application using the Gradle task `jsBrowserRun`. It will open in your default browser with hot-reloading enabled.
