import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End App Flow', () {
    testWidgets('Splash -> Onboarding -> Login -> Home -> Checkout -> Booking Form -> Ringkasan -> Pembayaran -> Berhasil', (WidgetTester tester) async {
      // 1. Load app widget
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle();

      // 2. Wait for Splash Screen exit transition (2.5 seconds delay in splash screen)
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // 3. Skip Onboarding
      final skipButton = find.text('Skip');
      expect(skipButton, findsOneWidget);
      await tester.tap(skipButton);
      await tester.pumpAndSettle();

      // 4. Fill Login form
      final emailField = find.widgetWithText(TextField, 'Masukkan alamat email');
      final passwordField = find.widgetWithText(TextField, 'Masukkan kata sandi');
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);

      await tester.enterText(emailField, 'admin@gmail.com');
      await tester.enterText(passwordField, 'admin123');
      await tester.pumpAndSettle();

      // Tap "Masuk" button
      final loginButton = find.text('Masuk');
      expect(loginButton, findsOneWidget);
      await tester.tap(loginButton);
      await tester.pump();
      
      // Wait for login mock API latency (2 seconds delay)
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // 5. Verify Home Screen is rendered
      expect(find.text('Hondaku'), findsOneWidget);

      // Tap the first "Beli" button to go to Checkout
      final beliButton = find.text('Beli').first;
      expect(beliButton, findsOneWidget);
      await tester.tap(beliButton);
      await tester.pumpAndSettle();

      // 6. Checkout Payment Method Screen
      expect(find.text('Metode Pembayaran'), findsOneWidget);
      
      // Select cash method (first payment option)
      final cashOption = find.text('Tunai (Cash)');
      expect(cashOption, findsOneWidget);
      await tester.tap(cashOption);
      await tester.pumpAndSettle();

      // Tap "Konfirmasi Metode"
      final confirmMethodBtn = find.text('Konfirmasi Metode');
      expect(confirmMethodBtn, findsOneWidget);
      await tester.tap(confirmMethodBtn);
      await tester.pumpAndSettle();

      // 7. Booking Form Page
      expect(find.text('Form Booking'), findsOneWidget);

      // Fill personal data
      await tester.enterText(find.widgetWithText(TextField, 'Contoh: Budi Setiawan'), 'Budi Setiawan');
      await tester.enterText(find.widgetWithText(TextField, '16 digit angka KTP'), '1234567890123456');
      await tester.enterText(find.widgetWithText(TextField, 'contoh@email.com'), 'budi@gmail.com');
      await tester.enterText(find.widgetWithText(TextField, '812xxxx'), '8123456789');
      
      // Scroll down to access shipping address and dropdowns
      final scrollable = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(find.widgetWithText(TextField, 'Jl. Ahmad Yani No. 123, Medan'), 100.0, scrollable: scrollable);
      await tester.enterText(find.widgetWithText(TextField, 'Jl. Ahmad Yani No. 123, Medan'), 'Jl. Setia Budi No. 45, Medan');
      await tester.pumpAndSettle();

      // Select Kecamatan
      final selectKecamatan = find.text('Pilih Kecamatan');
      expect(selectKecamatan, findsOneWidget);
      await tester.tap(selectKecamatan);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Medan Baru').last);
      await tester.pumpAndSettle();

      // Select Kelurahan
      final selectKelurahan = find.text('Pilih Kelurahan');
      expect(selectKelurahan, findsOneWidget);
      await tester.tap(selectKelurahan);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Suka Maju').last);
      await tester.pumpAndSettle();

      // Tap "Pilih Pembayaran Booking"
      final selectBookingBtn = find.text('Pilih Pembayaran Booking');
      expect(selectBookingBtn, findsOneWidget);
      await tester.tap(selectBookingBtn);
      await tester.pumpAndSettle();

      // 8. Ringkasan Pembayaran Page
      expect(find.text('Ringkasan Pembayaran'), findsOneWidget);
      final confirmPayBtn = find.text('Konfirmasi & Bayar Sekarang');
      expect(confirmPayBtn, findsOneWidget);
      await tester.tap(confirmPayBtn);
      await tester.pumpAndSettle();

      // 9. Pembayaran Booking Page
      expect(find.text('Instruksi Pembayaran'), findsOneWidget);
      final payDoneBtn = find.text('Saya Sudah Membayar');
      expect(payDoneBtn, findsOneWidget);
      await tester.tap(payDoneBtn);
      await tester.pumpAndSettle();

      // 10. Booking Berhasil Page
      expect(find.text('Booking Berhasil!'), findsOneWidget);
      final backToHomeBtn = find.text('Kembali ke Beranda');
      expect(backToHomeBtn, findsOneWidget);
      await tester.tap(backToHomeBtn);
      await tester.pumpAndSettle();

      // Verify returned to Home
      expect(find.text('Hondaku'), findsOneWidget);
    });
  });
}
