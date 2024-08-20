/**
 * Created by Abdullah on 20/8/24.
 */

name: CI/CD Pipeline

on:
push:
branches:
- main
- develop
- release/
  pull_request:
    branches:
      - main
      - develop

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.10.5'
      - run: flutter pub get
      - name: Run Tests
        run: flutter test
      - name: Build APK (for Android)
        run: flutter build apk --release
      - name: Build iOS (for iOS)
        run: flutter build ios --release --no-codesign
      - name: Deploy to Firebase
        run: flutter build web
