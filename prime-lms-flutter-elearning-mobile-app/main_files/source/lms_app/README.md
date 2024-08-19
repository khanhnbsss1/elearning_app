# lms_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# lms_app
- Build
    - Create app icon for android an ios
        - flutter pub run flutter_launcher_icons
    - Android
        - Webkit
            - flutter build apk -t lib/main.dart --release --flavor YAXChinese --no-tree-shake-icons
            - flutter build appbundle -t lib/main.dart --release --flavor YAXChinese  --no-tree-shake-icons
            - flutter build apk --flavor YAXChinese -t lib/main.dart --release
    - IOS
        - Webkit
            - flutter build ios -t lib/main.dart --flavor YAXChinese --no-tree-shake-icons
            - flutter -v -d 2CBE3629-E627-4E02-9687-D0BB0FC47002 run