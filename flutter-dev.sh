#!/bin/bash

# Flutter Development Helper Script for takao35_app
# Usage: ./flutter-dev.sh [command]

PROJECT_NAME="takao35_app"

case "$1" in
    "setup")
        echo "🔧 Setting up Flutter project..."
        flutter pub get
        flutter doctor
        echo "✅ Setup complete!"
        ;;
    "clean")
        echo "🧹 Cleaning project..."
        flutter clean
        flutter pub get
        echo "✅ Project cleaned!"
        ;;
    "run")
        echo "🚀 Running Flutter app..."
        flutter run
        ;;
    "run-debug")
        echo "🐛 Running Flutter app in debug mode..."
        flutter run --debug
        ;;
    "run-release")
        echo "🏃 Running Flutter app in release mode..."
        flutter run --release
        ;;
    "test")
        echo "🧪 Running tests..."
        flutter test
        ;;
    "analyze")
        echo "🔍 Analyzing code..."
        flutter analyze
        ;;
    "format")
        echo "✨ Formatting code..."
        flutter format .
        ;;
    "build-apk")
        echo "📦 Building APK..."
        flutter build apk --release
        echo "✅ APK built: build/app/outputs/flutter-apk/app-release.apk"
        ;;
    "build-ios")
        echo "📱 Building iOS..."
        flutter build ios --release
        echo "✅ iOS build complete!"
        ;;
    "devices")
        echo "📱 Available devices:"
        flutter devices
        ;;
    "doctor")
        echo "🩺 Flutter doctor:"
        flutter doctor -v
        ;;
    "upgrade")
        echo "⬆️ Upgrading dependencies..."
        flutter pub upgrade
        ;;
    "help"|*)
        echo "Flutter Development Helper for $PROJECT_NAME"
        echo ""
        echo "Usage: ./flutter-dev.sh [command]"
        echo ""
        echo "Available commands:"
        echo "  setup       - Initial project setup (pub get + doctor)"
        echo "  clean       - Clean and reset project"
        echo "  run         - Run the app"
        echo "  run-debug   - Run app in debug mode"
        echo "  run-release - Run app in release mode"
        echo "  test        - Run all tests"
        echo "  analyze     - Analyze code for issues"
        echo "  format      - Format all Dart code"
        echo "  build-apk   - Build Android APK"
        echo "  build-ios   - Build iOS app"
        echo "  devices     - List available devices"
        echo "  doctor      - Run Flutter doctor"
        echo "  upgrade     - Upgrade dependencies"
        echo "  help        - Show this help"
        ;;
esac