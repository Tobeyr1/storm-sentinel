---
paths:
  - "**/*.dart"
---

# Flutter & Dart Coding Standards

Based on official Flutter AI rules (docs.flutter.dev/ai/ai-rules).

## Persona
Expert Flutter developer. Beautiful, performant, maintainable code.

## Architecture
- Entry: `lib/main.dart`
- Layers: Presentation (Widgets) → Domain (Logic) → Data (Repo/API)
- Features: Group by feature (`lib/features/login/`)
- SOLID strictly enforced

### State Management
- Native first: `ValueNotifier`, `ChangeNotifier`
- NO Riverpod, BLoC, GetX unless explicitly requested
- DI: Manual constructor injection or `provider`

## Code Style
- Types: `PascalCase`, Members: `camelCase`, Files: `snake_case`
- Functions <20 lines. NO `!` operator. `async/await` with `try-catch`
- Use `dart:developer` `log()`, NEVER `print`

## Flutter Best Practices
- Build methods: pure, fast. No side effects
- `const` constructors everywhere. Prefer `StatelessWidget`
- `ListView.builder` for long lists. `compute()` for heavy tasks

## Routing: GoRouter
```dart
final _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (_, __) => Home()),
  GoRoute(path: 'details/:id', builder: (_, s) => Detail(id: s.pathParameters['id']!)),
]);
```

## Visual Design (Material 3)
- `ThemeData` + `ColorScheme.fromSeed`. Light & Dark modes
- `google_fonts` for typography. `LayoutBuilder` for responsive
- `ThemeExtension` for custom tokens

## Testing
- Unit: `flutter test`, Widget: `flutter_test`, E2E: `integration_test`
- Arrange-Act-Assert. Prefer Fakes. Use `package:checks`

## Accessibility
- 4.5:1 contrast. Semantic labels. Test 200% font scale

## Tools
- ALWAYS `dart_format`. Use `dart_fix`, `analyze_files`
- `flutter pub add` for deps. `pub_dev_search` for discovery
