# Flutter Widget Patterns

Practical patterns for widget composition. Not a tutorial — focus on pitfalls and best practices.

## Composition Rules

| Rule | Why |
|---|---|
| Extract widgets into separate classes, not methods | Methods don't get their own BuildContext or Element |
| Always use `const` constructors | Prevents unnecessary rebuilds |
| Prefer `StatelessWidget` | Simpler, more predictable, easier to test |
| Keep build() pure | No side effects, no network calls, no file I/O |

## BAD/GOOD: Widget Extraction

```dart
// BAD: method-based extraction
class MyPage extends StatelessWidget {
  Widget _buildHeader() => Text('Header'); // no BuildContext, no optimization
}

// GOOD: class-based extraction
class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) => Text('Header');
}
```

## BAD/GOOD: Const Constructors

```dart
// BAD: rebuilds every time parent rebuilds
Container(padding: EdgeInsets.all(16), child: Icon(Icons.star))

// GOOD: skipped during rebuild
const Padding(padding: EdgeInsets.all(16), child: Icon(Icons.star))
```

## Layout Patterns

| Pattern | When to Use |
|---------|------------|
| `Column` / `Row` | Fixed number of children |
| `ListView.builder` | Dynamic/long lists |
| `SliverList` + `CustomScrollView` | Mixed scroll content |
| `LayoutBuilder` | Responsive layout decisions |
| `FittedBox` | Scale content to fit constraints |

## Anti-Patterns

| Anti-pattern | Fix |
|---|---|
| `MediaQuery.of(context).size` in deep widgets | Use `LayoutBuilder` or pass constraints |
| Nested `SingleChildScrollView` | Use `CustomScrollView` with slivers |
| Hardcoded colors/sizes | Use `Theme.of(context)` and `ThemeExtension` |
| `GlobalKey` for widget communication | Use state management or callbacks |
