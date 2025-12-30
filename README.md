# Task

CRM-style Flutter application for managing clients and services.

## Features
- Client management (add, list)
- Clean Architecture
- GetX state management
- Modular routing

## Tech Stack
- Flutter
- Dart
- GetX
- Firebase
- Hive

## Folder Structure
lib/
├── core/
│   ├── constants/
│   ├── services/
│   └── utils/
├── data/
│   ├── models/
│   └── repositories/
├── presentation/
│   ├── clients/
│   └── auth/
├── routes/
└── main.dart

## Architecture
- Presentation layer: UI + GetX controllers
- Data layer: repositories & services
- Core layer: shared utilities & constants

## Setup Instructions

### Prerequisites
- Flutter SDK
- Android Studio / Xcode
- Git

### Run locally
```bash
flutter pub get
flutter run
