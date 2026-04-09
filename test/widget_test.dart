import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:storm_sentinel/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: StormSentinelApp()),
    );
    await tester.pumpAndSettle();
    expect(find.text('Storm Sentinel — framework'), findsOneWidget);
  });
}
