# Xuctu Mobile

Flutter prototype for the Xuctu Vietnamese mathematics learning experience. Phase 1 uses local dummy data and stores only the selected grade on the device.

## Requirements

- Flutter 3.38 or newer
- Android Studio and Android SDK for Android builds
- Xcode for iOS builds

## Run

```sh
flutter pub get
flutter run
```

## Verify

```sh
flutter analyze
flutter test
flutter build apk --debug
```

The prototype does not connect to a backend and does not include authentication, PDF reading, video playback, payments, or ordering.
