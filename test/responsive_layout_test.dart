import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hondaku/ui/features/auth/views/splash_screen.dart';
import 'package:hondaku/ui/features/auth/views/onboarding_screen.dart';
import 'package:hondaku/ui/features/auth/views/login_screen.dart';
import 'package:hondaku/ui/features/auth/views/register_screen.dart';

void main() {
  final List<Map<String, dynamic>> targetSizes = [
    {
      'name': 'Extremely Small Screen (e.g. 320x480)',
      'size': const Size(320, 480),
    },
    {
      'name': 'Narrow/Short Screen (e.g. iPhone SE - 320x568)',
      'size': const Size(320, 568),
    },
    {
      'name': 'Standard Modern Screen (e.g. 360x800)',
      'size': const Size(360, 800),
    },
    {
      'name': 'Large/Tall Screen (e.g. 412x915)',
      'size': const Size(412, 915),
    },
    {
      'name': 'Landscape Small Screen (e.g. 800x360)',
      'size': const Size(800, 360),
    },
  ];

  for (final target in targetSizes) {
    final String sizeName = target['name'] as String;
    final Size size = target['size'] as Size;

    group('Responsiveness Test - $sizeName -', () {
      testWidgets('Splash Screen', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final testRouter = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const SplashScreen(),
            ),
            GoRoute(
              path: '/onboarding',
              builder: (context, state) => const Scaffold(body: Text('Onboarding')),
            ),
          ],
        );

        await tester.pumpWidget(
          MaterialApp.router(
            routerConfig: testRouter,
          ),
        );
        await tester.pump();
        
        // No layout exception/overflow should occur
        expect(find.byType(SplashScreen), findsOneWidget);
        
        // Settle animation timer
        await tester.pump(const Duration(seconds: 3));
      });

      testWidgets('Onboarding Screen', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          const MaterialApp(
            home: OnboardingScreen(),
          ),
        );
        await tester.pump();

        expect(find.byType(OnboardingScreen), findsOneWidget);
        
        // Tap "Lanjutkan" to navigate to next slide
        final Finder buttonFinder = find.byType(ElevatedButton);
        if (buttonFinder.evaluate().isNotEmpty) {
          await tester.ensureVisible(buttonFinder);
          await tester.tap(buttonFinder);
          await tester.pumpAndSettle();
        }
      });

      testWidgets('Login Screen', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: LoginScreen(),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(LoginScreen), findsOneWidget);

        // Tap background to dismiss keyboard / trigger tap gesture detector
        await tester.tap(find.byType(LoginScreen));
        await tester.pump();
      });

      testWidgets('Register Screen', (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(
          const ProviderScope(
            child: MaterialApp(
              home: RegisterScreen(),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(RegisterScreen), findsOneWidget);
      });
    });
  }
}
