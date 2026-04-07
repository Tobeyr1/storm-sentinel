---
name: flutter-dev
description: >-
  Flutter and Dart development best practices, architecture patterns, widget
  optimization, and platform-specific guidance. Use for questions about Flutter
  widgets, state management, navigation, theming, testing, platform channels,
  or any Dart/Flutter development topic.
---

# Flutter Development Skill

## When to Use This Skill

Activate when the user asks about:
- Flutter widget design, composition, optimization
- State management (ChangeNotifier, Provider, BLoC, Riverpod)
- Navigation and routing (GoRouter, Navigator 2.0)
- Material 3 theming, responsive design
- Flutter testing (unit, widget, integration, golden)
- Platform channels (Android/iOS interop)
- Performance optimization (widget rebuilds, isolates, DevTools)
- Package selection and pub.dev discovery
- Flutter Web, Desktop, embedded targets
- Dart language features (null safety, streams, isolates, records, patterns)

## Core Principles

### Widget Design
- Prefer composition over inheritance
- `const` constructors for all stateless widgets
- Small, focused widgets (single responsibility)
- Separate screen widgets from reusable components

### State Management
- Ephemeral state: `setState`, `ValueNotifier`
- App state: `ChangeNotifier` + `ListenableBuilder` (native first)
- Only use BLoC/Riverpod/GetX when explicitly requested or project already uses them

### Performance
- Profile before optimizing (use Flutter DevTools)
- `ListView.builder` for dynamic lists
- `RepaintBoundary` for complex animations
- `compute()` for CPU-intensive work
- Minimize `setState` scope

### Testing
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for critical flows
- Golden tests for visual regression

## Dart MCP Server

This project includes the official Dart and Flutter MCP server configuration.
When the user is working on a Flutter project, the AI can use MCP tools to:
- Analyze code and fix errors
- Search pub.dev for packages
- Manage pubspec.yaml dependencies
- Run tests and format code
- Inspect running applications

## Reference Catalog

| Topic | File |
|-------|------|
| Widget Best Practices | `references/widget-patterns.md` |
| State Management Guide | `references/state-management.md` |
| Testing Strategy | `references/testing-flutter.md` |
