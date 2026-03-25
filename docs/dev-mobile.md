# Mobile development

Mobile development involves creating software applications for smartphones and tablets. This guide covers several popular cross-platform frameworks that allow developers to build apps for both iOS and Android from a single codebase, maximizing efficiency and reach. Below, you'll find introductions to React Native, Flutter, and Kotlin Multiplatform, each offering a different approach to building high-quality mobile experiences.

## React Native

[React Native](https://reactnative.dev/) enables you to build natively-rendering mobile apps for iOS and Android using [React](https://react.dev/) and JavaScript. Unlike web-view-based solutions, React Native uses the same fundamental UI building blocks as regular iOS and Android apps, so your app will have a truly native look and feel. It's an excellent choice for teams with a web development background in React.

### Get Started

- 🚀 **Start with Expo Go:** The fastest way to get started is with [Expo](https://expo.dev/). Use the [Expo Go](https://expo.dev/go) app on your phone to run your project instantly without needing to install Xcode or Android Studio.
  ```sh
  npx create-expo-app my-app
  ```
- 📖 **Learn the Core Components:** Familiarize yourself with React Native's Core Components like `<View>`, `<Text>`, `<Image>`, and `<ScrollView>`. These are the essential building blocks for your UI.
- 🧭 **Handle Navigation:** Mobile apps have different navigation patterns than websites. Learn a library like React Navigation to manage screens and navigation stacks.
- ⚙ **Eject when needed:** While Expo is great for starting, you may eventually need to write custom native code. The React Native CLI path gives you full control, but requires managing native build tools.

## Flutter

[Flutter](https://flutter.dev/) is a UI toolkit from Google for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. It uses the [Dart](https://dart.dev/) programming language and a reactive, widget-based architecture to enable fast development and expressive, flexible UIs.

### Get Started

- ⚙ **Install the SDK:** Follow the official installation guide for your operating system.
- 🩺 **Check your environment:** After installation, run `flutter doctor` in your terminal. This command checks your environment and displays a report of the status of your Flutter installation, including any missing dependencies you need to install.
- 📦 **Start with the basics:** Work through the "Write your first Flutter app" codelab to get a hands-on feel for its declarative UI and stateful hot reload.
- 🛠 **Use an IDE:** For the best experience, develop with Android Studio (for its Android SDK and emulator management) or VS Code with the official Flutter and Dart extensions.

## Kotlin Multiplatform (KMP)

[Kotlin Multiplatform (KMP)](https://kotlinlang.org/lp/multiplatform/) is a technology from [JetBrains](https://www.jetbrains.com/) that allows you to share code across different platforms while retaining the benefits of native programming. Unlike UI-centric frameworks, KMP's strength is in sharing non-UI code—such as business logic, data layers, and network communication—between Android, iOS, web, and desktop apps. This allows you to write platform-specific UI with [Jetpack Compose](https://developer.android.com/jetpack/compose) (Android) and [SwiftUI](https://developer.apple.com/xcode/swiftui/) (iOS) while sharing the core application logic written in [Kotlin](./kotlin.md).

### Get Started

- 📖 **Understand the philosophy:** KMP is about sharing logic, not UI. Your goal is to write common modules in Kotlin that can be consumed by native projects on each target platform.
- ⚙ **Use the official wizard:** The easiest way to start is with the Kotlin Multiplatform wizard in Android Studio (or IntelliJ IDEA). It sets up the project structure with shared and platform-specific source sets.
- 📦 **Start small:** Create a simple project that shares a data class or a basic function (e.g., a string validator). This will help you understand the `expect`/`actual` mechanism for platform-specific implementations.
- 🔗 **Focus on the data layer:** A common and effective use case is to share your repository pattern, data sources, and API clients, which often contain complex logic that is identical across platforms.
