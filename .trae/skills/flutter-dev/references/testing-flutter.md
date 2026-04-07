# Flutter Testing Guide

Practical testing patterns. Use Arrange-Act-Assert. Prefer fakes over mocks.

## Test Types

| Type | Tool | Speed | Scope |
|------|------|-------|-------|
| Unit | `flutter test` | Fast | Business logic, models |
| Widget | `flutter_test` | Medium | Single widget behavior |
| Integration | `integration_test` | Slow | Full app flows |
| Golden | `matchesGoldenFile` | Medium | Visual regression |

## Widget Test Pattern

```dart
testWidgets('counter increments', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: CounterPage()));

  expect(find.text('0'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('1'), findsOneWidget);
});
```

## Testing with State

```dart
testWidgets('shows loading then data', (tester) async {
  final notifier = FakeDataNotifier();
  await tester.pumpWidget(
    MaterialApp(home: DataPage(notifier: notifier)),
  );

  expect(find.byType(CircularProgressIndicator), findsOneWidget);

  notifier.setData(['item1', 'item2']);
  await tester.pump();

  expect(find.text('item1'), findsOneWidget);
});
```

## What to Test

| Always Test | Skip |
|---|---|
| Business logic / calculations | Framework internals |
| Widget interaction (tap, scroll) | Default Material behavior |
| Error states and edge cases | Simple getters |
| Navigation and routing | Trivial UI layout |

## Anti-Patterns

| Anti-pattern | Fix |
|---|---|
| Testing implementation details | Test behavior via UI |
| Not pumping after state changes | `await tester.pump()` after every change |
| Using real HTTP in tests | Use fake/mock HTTP client |
| No golden tests for design system | Add golden tests for shared widgets |
