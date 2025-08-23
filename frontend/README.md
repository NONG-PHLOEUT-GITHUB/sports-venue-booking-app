## Sports_venue_booking

## Introduction
This is a Flutter application designed to run on Android, iOS, Web, and Desktop. It provides a modern, responsive UI with state management and backend integration.

## Features
- Cross-platform support (Android, iOS, Web, Desktop)
- Responsive UI with Material Design
- State management using Provider, Riverpod, or Bloc (choose one based on your project)
- API integration with REST or GraphQL
- Local storage using Hive, SharedPreferences, or SQLite
- Authentication (Firebase, OAuth, JWT-based authentication, etc.)

## Requirements
- Flutter SDK (latest stable version)
- Dart (latest version)
- Android Studio or VS Code (with Flutter & Dart plugins installed)
- Xcode (for iOS development)

## Installation

### 1. Install dependencies

- flutter pub get

### 2. Run the application
## For Android & iOS:

- flutter run

## For Web:

- flutter run -d chrome

## For Desktop (Windows, macOS, Linux):

- flutter run -d windows   # or macos, linux

### clearn dependencies

- flutter clean

## Build & Release
### Build APK (Android)

- flutter build apk --release


### Build iOS App

- flutter build ios --release


### Build Web App

- flutter build web


### Build for Desktop

- flutter build windows  # or macos, linux


# 🔥 Firebase Setup for Flutter (Android)

To use Firebase services (Authentication, Firestore, etc.), follow these steps:

# 1️⃣ Login to Firebase
firebase login

# 2️⃣ Create a Firebase Project
# 👉 Go to Firebase Console → Add Project → Enter project name (e.g., sports_venue_booking)
# 👉 Enable/Disable Google Analytics (optional)
# 👉 Click Create Project

# 3️⃣ Add Firebase to Flutter (Android)
# 👉 In Firebase Console → Project → Add App → Select Android
# 👉 Enter package name (from android/app/build.gradle or build.gradle.kts → applicationId)
# 👉 Download google-services.json
# 👉 Move file to:
mv ~/Downloads/google-services.json android/app/

# 4️⃣ Update Gradle files

# 📌 Project-level Gradle (android/build.gradle)
cat >> android/build.gradle << 'EOL'

buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
EOL

# 📌 App-level Gradle (android/app/build.gradle or build.gradle.kts)
cat >> android/app/build.gradle.kts << 'EOL'

plugins {
    id("com.google.gms.google-services")
}

## contact 
phloeutnong@gmail.com