import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/app/app.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify that our initialization text is present.
    expect(find.text('KineticAI Initialized with Riverpod'), findsOneWidget);
  });
}
