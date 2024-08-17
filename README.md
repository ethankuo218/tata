# TATA

TATA is a stress-free and soul-soothing anonymous chat platform where users can find someone to chat and share their thoughts with at any time.

## Getting Started

To get started with the TATA project, follow these steps:

1. Install Flutter packages:

```
flutter pub get
```

2. The project uses flavor configurations for development and production environments. To run the app in different environments, use the following commands:

   - For development:

     ```
     flutter run --flavor dev -t lib/main_dev.dart
     ```

   - For production:
     ```
     flutter run --flavor prod -t lib/main_prod.dart
     ```

## Project Structure

The project follows a typical Flutter application structure with some additional folders for better organization:

- `lib/`: Contains the main Dart code for the application
- `assets/`: Stores static assets like images, fonts, and icons
- `ios/` and `android/`: Platform-specific code and configurations
- `test/`: Unit and widget tests

## Features

- Anonymous chat rooms
- Tarot night activity
- Multi-language support (English and Traditional Chinese)
- Firebase integration for authentication and data storage

## Dependencies

The project uses several key dependencies, including:

- Flutter SDK
- Firebase (Auth, Firestore)
- Riverpod for state management
- flutter_localizations for internationalization

For a complete list of dependencies, refer to the `pubspec.yaml` file.

## Configuration

The project uses flavor configurations for different environments. The configurations are defined in the `flavorizr.yaml` file:

```1:25:flavorizr.yaml
flavors:
  dev:
    app:
      name: "TATA (Dev)"

    android:
      applicationId: "com.eq.tata.dev"
      firebase:
        config: ".firebase/dev/google-services.json"
    ios:
      bundleId: "com.eq.tata.dev"
      firebase:
        config: ".firebase/dev/GoogleService-Info.plist"
  prod:
    app:
      name: "TATA"

    android:
      applicationId: "com.eq.tata"
      firebase:
        config: ".firebase/prod/google-services.json"
    ios:
      bundleId: "com.eq.tata"
      firebase:
        config: ".firebase/prod/GoogleService-Info.plist"
```

## Building and Running

To build the app for different environments:

- Development:

  ```
  flutter build ios --flavor dev -t lib/main_dev.dart
  flutter build appbundle --flavor dev -t lib/main_dev.dart
  ```

- Production:
  ```
  flutter build ios --flavor prod -t lib/main_prod.dart
  flutter build appbundle --flavor prod -t lib/main_prod.dart
  ```
