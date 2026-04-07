# Flutter State Management

Decision guide for choosing state management in Flutter. Native-first approach.

## Decision Matrix

| Scope | Complexity | Recommended |
|-------|-----------|-------------|
| Single widget | Low | `setState` |
| Single widget, external | Low | `ValueNotifier` + `ValueListenableBuilder` |
| Feature-scoped | Medium | `ChangeNotifier` + `ListenableBuilder` |
| App-wide | Medium | `provider` or `InheritedWidget` |
| Complex async | High | `Stream` + `StreamBuilder` |
| User-requested | Any | BLoC / Riverpod / GetX (follow their patterns) |

## Native Patterns

### ValueNotifier (simplest)
```dart
final counter = ValueNotifier<int>(0);

ValueListenableBuilder<int>(
  valueListenable: counter,
  builder: (_, value, __) => Text('$value'),
)
```

### ChangeNotifier (feature state)
```dart
class CartNotifier extends ChangeNotifier {
  final List<Item> _items = [];
  List<Item> get items => List.unmodifiable(_items);

  void add(Item item) { _items.add(item); notifyListeners(); }
  void remove(Item item) { _items.remove(item); notifyListeners(); }
}
```

## Anti-Patterns

| Anti-pattern | Why Harmful | Fix |
|---|---|---|
| `setState` for app-wide state | Prop drilling, rebuilds too much | Lift state up, use provider |
| Notifier in build() | Creates new instance each rebuild | Create in initState or outside |
| Not disposing notifiers | Memory leaks | Dispose in State.dispose() |
| Mixing multiple state solutions | Confusion, maintenance burden | Pick one approach per project |
