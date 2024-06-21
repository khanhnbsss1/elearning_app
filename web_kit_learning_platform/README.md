# webkit

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- Run:
  - Android:
    - Webkit
      - flutter run -t lib/main.dart --flavor Webkit
  - Web:
    - Webkit
      - flutter run -d chrome --dart-define=flavor=dev -t lib/main.dart -d chrome --web-browser-flag "--disable-web-security"
      - flutter run web --dart-define=flavor=stg -t lib/main.dart
      - flutter run web --dart-define=flavor=prod -t lib/main.dart

- Build
    - Create app icon for android an ios
        - flutter pub run flutter_launcher_icons
    - Android
        - Webkit
            - flutter build apk -t lib/main.dart --release --flavor YAXChineseLearning --no-tree-shake-icons
            - flutter build appbundle -t lib/main.dart --release --flavor FinancialAdmin  --no-tree-shake-icons
            - flutter build apk --flavor YAXChineseLearning -t lib/main.dart --release
    - IOS
        - Webkit
            - flutter build ios -t lib/main.dart --flavor Webkit --no-tree-shake-icons
            - flutter -v -d 2CBE3629-E627-4E02-9687-D0BB0FC47002 run
    - Web:
      - Webkit
        - flutter build web --dart-define=flavor=dev --release -t lib/main.dart
        - flutter build web --dart-define=flavor=stg --release -t lib/main.dart
        - flutter build web --dart-define=flavor=pro --release -t lib/main.dart