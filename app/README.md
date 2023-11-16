# 🦫 Bebras Pandai App

[![Flutter Version](https://img.shields.io/badge/Flutter-v3.13.0-blue.svg)](https://flutter.dev/docs)
[![Dart Version](https://img.shields.io/badge/Dart-v3.1.0-blue.svg)](https://flutter.dev/)
[![Generic badge](https://img.shields.io/badge/Platform-Android%20and%20iOS-purple)](https://dart.dev/guides)
[![Generic badge](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

## 📍 Implemented
- [X] Atomic Design.
- [X] Core Material Component.
- [X] Linter.
- [X] Github Actions (CI/CD).
- [X] Formatter.

## ⚡️ Getting Started
### 🎯 Architecture & Pattern

Reso coder's fllutter clean architecture

![alt text](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?ssl=1)

### 🧬️ State Management

Using [flutter BLoC](https://pub.dev/packages/flutter_bloc) for Business Logic Component Design Pattern.

### 🚚 How to run and build Apk
Example how to run debug development app
```shell
make init
make dev
```

Example how to run release development app
```shell
make init
make build_apk
```

### 🔑 Authentication
**Android**
1. Download `.env` & `google-services.json` file from Firebase storage `secret` directory \
    (ask in the group if you aren't sure how to do this, please don't download it from the project menu & renewing the key)
1. Put `.env` in this `app/` directory, and `google-services.json` inside `app/android/app/`
1. Add your SHA1 key in the `Project settings` > `Android apps` \
    https://www.geeksforgeeks.org/how-to-generate-sha-1-key-in-flutter/
1. Follow the step in [this section](#-how-to-run-and-build-apk) to test it

**iOS**
1. Download `.env`, `GoogleService-Info.plist`, and `Info.plist` file from Firebase storage `secret` directory \
    (ask in the group if you aren't sure how to do this, please don't download it from the project menu & renewing the key)
1. Put `.env` in this `app/` directory, while the `*.plist` files inside `app/ios/Runner/`
1. Open finder, then go to `app/ios` directory
1. Right click `Runner.xcodeproj`, choose open with `Xcode.app`
1. Add `GoogleService-Info.plist` into the `Runner` directory inside `Xcode.app`
1. Follow the step in [this section](#-how-to-run-and-build-apk) to test it