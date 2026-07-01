import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/ui/features/auth/views/login_screen.dart';
import 'package:hondaku/l10n/app_localizations.dart';
import 'package:hondaku/ui/features/auth/providers/auth_provider.dart';
import 'package:hondaku/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuthRepository implements AuthRepository {
  @override
  Future<UserCredential> loginWithEmail(String email, String password) async {
    throw Exception('Login Failed Mock');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('LoginScreen initial rendering and inputs validation', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(MockFirebaseAuthRepository()),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('id'),
          home: LoginScreen(),
        ),
      ),
    );

    // Verify fields and button exist
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('KATA SANDI'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);

    // Type invalid email/password and submit
    await tester.enterText(find.byType(TextField).at(0), 'wrong@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'wrongpass');
    await tester.tap(find.text('Masuk'));
    
    // Pump frames to complete the Future delay in AuthViewModel
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify error dialog appears
    expect(find.byType(CupertinoAlertDialog), findsOneWidget);
    expect(find.text('Login Gagal'), findsOneWidget);
    expect(find.text('Exception: Login Failed Mock'), findsOneWidget);

    // Tap OK on the dialog to dismiss
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify dialog is gone
    expect(find.byType(CupertinoAlertDialog), findsNothing);
  });
}
