# Desktop development

Desktop app development focuses on creating software applications that run natively on operating systems like [Windows](https://www.microsoft.com/windows), [macOS](https://www.apple.com/macos/), and [Linux](https://www.linuxfoundation.org/). While this traditionally required separate codebases for each platform, modern development has shifted towards cross-platform frameworks. These toolkits allow developers to write code once and deploy it across desktop, mobile, and web, dramatically improving efficiency and ensuring a consistent user experience. This guide explores three prominent frameworks that excel at this "write-once, run-anywhere" philosophy: React Native, Flutter, and Kotlin Multiplatform.

## React Native

While [React Native](https://reactnative.dev/) is famous for mobile development, its ecosystem has expanded to support desktop platforms through community and corporate-backed efforts. Projects like **[React Native for Windows](https://microsoft.github.io/react-native-windows/)** and **[React Native for macOS](https://github.com/microsoft/react-native-macos)** allow developers to leverage their existing [React](./dev-web.md#react) and JavaScript skills to build native desktop applications.

The core principle remains the same: you define your UI with React components, and the framework translates them into native UI elements for the target desktop OS. This approach enables significant code sharing between mobile and desktop apps, making it an excellent choice for teams already invested in the React ecosystem.

### Get Started

- 📖 **Explore the documentation:** Visit the official sites for React Native for Windows and macOS to understand setup, platform-specific APIs, and best practices.
- ⚙ **Use the CLI:** Follow the official guides to add desktop support to an existing React Native project or to create a new one from scratch.
- 📦 **Understand Native Modules:** For desktop-specific functionality (like interacting with the file system or system tray), you'll need to learn how to use or create native modules.

## Flutter

[Flutter](./flutter.md) is Google's UI toolkit for building beautiful, natively compiled applications for desktop, mobile, and web from a single codebase. Unlike frameworks that wrap native components, Flutter uses its own high-performance rendering engine (Skia) to draw every pixel on the screen. This gives developers complete control over the UI and ensures a consistent look and feel across all platforms.

### Get Started

- ⚙ **Enable desktop support:** If you have Flutter installed, run `flutter config --enable-<platform>-desktop` (e.g., `flutter config --enable-windows-desktop`) to enable support for your target OS.
- 🚀 **Create a new project:** Run `flutter create my_desktop_app` to generate a new project with desktop support included.
- 📦 **Run your app:** You can run your application on your desktop with `flutter run -d <platform>` (e.g., `flutter run -d windows`).
- 🛠 **Learn about platform integration:** While the UI is consistent, you may need to use platform-specific plugins for features like window management or system dialogs.

## Kotlin Multiplatform

[Compose Multiplatform](https://www.jetbrains.com/lp/compose-multiplatform/), an extension of [Kotlin Multiplatform](https://kotlinlang.org/lp/multiplatform/), allows developers to build UIs for desktop, web, and mobile from a single, shared [Kotlin](./kotlin.md) codebase. It leverages the [Jetpack Compose](https://developer.android.com/jetpack/compose) paradigm, bringing a modern, declarative UI framework to the desktop.

For desktop development, Compose Multiplatform compiles your [Kotlin](./kotlin.md) code into a native application packaged with a [Java Virtual Machine (JVM)](./java.md). This enables teams to share not only business logic (a core strength of KMP) but also the entire user interface, ensuring consistency and accelerating development across platforms. It's an ideal choice for developers in the Android or [Kotlin](./kotlin.md) ecosystem.

### Get Started

- 📖 **Explore Compose for Desktop:** Read the official Compose Multiplatform for Desktop documentation to understand its capabilities.
- ⚙ **Use the KMP Wizard:** The easiest way to start is with the Kotlin Multiplatform wizard in IntelliJ IDEA. Select the "Desktop" target to generate a project with the necessary configuration.
- 🚀 **Learn the Compose Mindset:** If you're new to Compose, learn the fundamentals of declarative UI, including Composable functions, state management, and modifiers. The principles are the same as on Android.
- 📦 **Run your desktop app:** Once your project is set up, you can run your desktop application using the Gradle task `run`.
