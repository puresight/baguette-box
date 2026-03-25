# Flutter

[Flutter](https://flutter.dev/) is a UI toolkit from Google for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. It uses the [Dart](https://dart.dev/) programming language and a reactive, widget-based architecture.

Unlike frameworks that wrap native components, Flutter uses its own high-performance rendering engine (Skia) to draw every pixel on the screen. This gives developers complete control over the UI and ensures a consistent look and feel across all platforms, enabling fast development and expressive, flexible UIs.

- Run recipe `install-flutter`
- Run `flutter doctor` to verify your setup and install any missing dependencies

## Get Started

- **Create a new project:**
  ```sh
  flutter create my_app
  ```
- **Run the app:** Navigate into the new directory and run the app. You can target a specific device (like `chrome`, `windows`, or a connected mobile device ID).
  ```sh
  cd my_app
  flutter run -d chrome
  ```
- **Learn the basics:** Work through the "Write your first Flutter app" codelab to get a hands-on feel for its declarative UI and stateful hot reload.
- **Understand the architecture:** Familiarize yourself with core concepts like the widget tree, state management, and layout constraints (e.g., `Row`, `Column`, `Container`).

## Multi-Platform Development

Flutter's power lies in its single codebase for multiple platforms. You can enable support for platforms beyond mobile.

- **Web:** `flutter config --enable-web`
- **Desktop:** `flutter config --enable-<platform>-desktop` (replace `<platform>` with `windows`, `macos`, or `linux`)

After enabling, new projects will automatically include support. You can add support to existing projects by running `flutter create .` in the project directory.

See more details in the development guides: [Web](./dev-web.md) | [Mobile](./dev-mobile.md) | [Desktop](./dev-desktop.md)
