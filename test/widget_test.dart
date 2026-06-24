import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/main.dart';
import 'package:hondaku/ui/features/auth/views/splash_screen.dart';

void main() {
  testWidgets('Splash screen render smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that the SplashScreen is rendered.
    expect(find.byType(SplashScreen), findsOneWidget);

    // Let the splash navigation timer complete to avoid pending timer assertions
    await tester.pump(const Duration(seconds: 4));
  });
}
