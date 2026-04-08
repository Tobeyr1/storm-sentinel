---
paths:
  - "**/*.dart"
---

# Flutter Architecture & State Management

## Feature-Based Structure
```
lib/
├── main.dart
├── app/ (app.dart, router.dart, theme.dart)
├── features/
│   ├── auth/ (ui/, domain/, data/, state/)
│   └── home/
├── shared/ (widgets/, utils/, constants/)
└── l10n/
```

## State Management Decision

| Scope | Approach |
|-------|----------|
| Local widget | `setState` or `ValueNotifier` |
| Feature-scoped | `ChangeNotifier` + `ListenableBuilder` |
| App-wide | `InheritedWidget` or `provider` |
| Complex async | `Stream` + `StreamBuilder` |
| User requests BLoC/Riverpod | Use requested pattern |

## Repository Pattern
```dart
abstract class UserRepository {
  Future<User> getUser(String id);
}

class ApiUserRepository implements UserRepository {
  final http.Client _client;
  ApiUserRepository(this._client);

  @override
  Future<User> getUser(String id) async {
    final response = await _client.get(Uri.parse('/users/$id'));
    return User.fromJson(jsonDecode(response.body));
  }
}
```

## Error Handling
```dart
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> { final T data; const Success(this.data); }
class Failure<T> extends Result<T> { final String message; const Failure(this.message); }
```

## Anti-Patterns
| Anti-pattern | Fix |
|---|---|
| Business logic in build() | Move to notifier/controller |
| Global mutable state | Scoped state + DI |
| setState for app state | provider or InheritedWidget |
| Not disposing notifiers | Dispose in State.dispose() |
