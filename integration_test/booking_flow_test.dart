import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hondaku/domain/models/motorcycle.dart';
import 'package:hondaku/ui/features/booking/views/booking_form_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const dummyMotor = Motorcycle(
    id: 'm1',
    name: 'Honda Beat Sporty',
    subtitle: 'Matic Lincah',
    description: 'Desc',
    price: 'Rp 18.000.000',
    imageAsset: 'test.jpg',
    categoryBadge: 'MATIC',
    engine: '110cc',
    maxPower: '9 HP',
    fuelCapacity: '4.2L',
    features: [],
    specsMesin: {},
    specsRangka: {},
    specsDimensi: {},
  );

  Widget createTestWidget({required GoRouter router}) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  Future<void> fillForm({
    required WidgetTester tester,
    String name = 'Aldo Sebastian',
    String nik = '1234567890123456',
    String email = 'test@example.com',
    String kecamatan = 'Medan Baru',
    String kelurahan = 'Suka Maju',
    String phone = '8123456789',
    String alamat = 'Jl. Sunggal No. 45',
  }) async {
    final nameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Contoh: Budi Setiawan');
    final nikField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '16 digit angka KTP');
    final emailField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'contoh@email.com');
    final phoneField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '812xxxx');
    final alamatField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Jl. Ahmad Yani No. 123, Medan');

    if (name.isNotEmpty) {
      await tester.ensureVisible(nameField);
      await tester.enterText(nameField, name);
      await tester.pump();
    }
    if (nik.isNotEmpty) {
      await tester.ensureVisible(nikField);
      await tester.enterText(nikField, nik);
      await tester.pump();
    }
    if (email.isNotEmpty) {
      await tester.ensureVisible(emailField);
      await tester.enterText(emailField, email);
      await tester.pump();
    }

    if (kecamatan.isNotEmpty) {
      final kecamatanDropdown = find.text('Pilih Kecamatan');
      await tester.ensureVisible(kecamatanDropdown);
      await tester.tap(kecamatanDropdown);
      await tester.pumpAndSettle();
      final kecamatanItem = find.text(kecamatan).last;
      await tester.tap(kecamatanItem);
      await tester.pumpAndSettle();
    }

    if (kelurahan.isNotEmpty) {
      final kelurahanDropdown = find.text('Pilih Kelurahan');
      await tester.ensureVisible(kelurahanDropdown);
      await tester.tap(kelurahanDropdown);
      await tester.pumpAndSettle();
      final kelurahanItem = find.text(kelurahan).last;
      await tester.tap(kelurahanItem);
      await tester.pumpAndSettle();
    }

    final scrollable = find.byType(SingleChildScrollView);
    await tester.drag(scrollable, const Offset(0, -300));
    await tester.pumpAndSettle();

    if (phone.isNotEmpty) {
      await tester.ensureVisible(phoneField);
      await tester.enterText(phoneField, phone);
      await tester.pump();
    }
    if (alamat.isNotEmpty) {
      await tester.ensureVisible(alamatField);
      await tester.enterText(alamatField, alamat);
      await tester.pumpAndSettle();
    }
  }

  group('Tier 1: Feature Coverage', () {
    testWidgets('F1_T1_1: Entering a valid Name updates state correctly', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      final nameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Contoh: Budi Setiawan');
      await tester.enterText(nameField, 'Aldo Sebastian');
      await tester.pump();
      expect(find.text('Aldo Sebastian'), findsOneWidget);
    });

    testWidgets('F1_T1_2: Entering a valid 16-digit NIK updates state', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      final nikField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '16 digit angka KTP');
      await tester.enterText(nikField, '1234567890123456');
      await tester.pump();
      expect(find.text('1234567890123456'), findsOneWidget);
    });

    testWidgets('F1_T1_3: Entering a valid email updates state', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      final emailField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'contoh@email.com');
      await tester.enterText(emailField, 'test@example.com');
      await tester.pump();
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('F1_T1_4: Selecting a valid Kecamatan and Kelurahan updates state', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      final kecamatanDropdown = find.text('Pilih Kecamatan');
      await tester.tap(kecamatanDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Medan Baru').last);
      await tester.pumpAndSettle();

      final kelurahanDropdown = find.text('Pilih Kelurahan');
      await tester.tap(kelurahanDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Suka Maju').last);
      await tester.pumpAndSettle();

      expect(find.text('Medan Baru'), findsOneWidget);
      expect(find.text('Suka Maju'), findsOneWidget);
    });

    testWidgets('F1_T1_5: Entering a valid Address and Phone updates state', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      final scrollable = find.byType(SingleChildScrollView);
      await tester.drag(scrollable, const Offset(0, -300));
      await tester.pumpAndSettle();

      final phoneField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '812xxxx');
      await tester.enterText(phoneField, '8123456789');
      await tester.pump();

      final alamatField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Jl. Ahmad Yani No. 123, Medan');
      await tester.enterText(alamatField, 'Jl. Sunggal No. 45');
      await tester.pump();

      expect(find.text('8123456789'), findsOneWidget);
      expect(find.text('Jl. Sunggal No. 45'), findsOneWidget);
    });

    testWidgets('F2_T1_1: Verifies default payment type is "Booking Unit" with Rp 500,000 fee', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      expect(find.text('BIAYA RESERVASI (BOOKING)'), findsOneWidget);
      expect(find.text('Rp 500.000'), findsWidgets);
    });

    testWidgets('F2_T1_2: Selecting "Pelunasan Full" chip updates the payment labels and displays total price', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();

      expect(find.text('TOTAL PELUNASAN (FULL)'), findsOneWidget);
      expect(find.text('18.000.000'), findsWidgets);
    });

    testWidgets('F2_T1_3: Toggling back to "Booking Unit" resets the price to the booking fee', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Booking Unit'));
      await tester.pumpAndSettle();

      expect(find.text('BIAYA RESERVASI (BOOKING)'), findsOneWidget);
      expect(find.text('Rp 500.000'), findsWidgets);
    });

    testWidgets('F2_T1_4: Cash booking method displays the booking fee summary', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      expect(find.text('Biaya untuk mengamankan antrian unit. Akan memotong harga OTR saat pelunasan nanti.'), findsOneWidget);
    });

    testWidgets('F2_T1_5: Selecting "Pelunasan Full" displays the full OTR price in the bottom bar', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();

      final scrollable = find.byType(SingleChildScrollView);
      await tester.drag(scrollable, const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(find.text('Rp 18.000.000'), findsWidgets);
    });

    testWidgets('F3_T1_1 & F3_T1_2: Tapping button with valid details submits form and navigates to summary', (WidgetTester tester) async {
      bool routed = false;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            routed = true;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester);

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(routed, isTrue);
    });

    testWidgets('F3_T1_3 & F3_T1_4: Navigation passes correct motorcycle data and payment type parameter', (WidgetTester tester) async {
      Motorcycle? passedMotor;
      bool? passedFullPayment;

      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            final extra = s.extra as Map<String, dynamic>;
            passedMotor = extra['motor'] as Motorcycle;
            passedFullPayment = extra['isFullPayment'] as bool;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester);

      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(passedMotor?.name, 'Honda Beat Sporty');
      expect(passedFullPayment, isTrue);
    });

    testWidgets('F3_T1_5: Verifies the button text reads "Pilih Pembayaran Booking"', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      expect(find.text('Pilih Pembayaran Booking'), findsOneWidget);
    });
  });

  group('Tier 2: Boundary & Corner Cases', () {
    testWidgets('F1_T2_1: Submitting empty name triggers error', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();

      expect(find.text('Nama belum diisi'), findsWidgets);
    });

    testWidgets('F1_T2_2: Submitting short NIK triggers error', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      final nameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Contoh: Budi Setiawan');
      await tester.enterText(nameField, 'Aldo Sebastian');
      await tester.pump();

      final nikField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '16 digit angka KTP');
      await tester.enterText(nikField, '12345');
      await tester.pump();

      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();

      expect(find.text('NIK harus minimal 15-16 digit'), findsWidgets);
    });

    testWidgets('F1_T2_3: Submitting invalid email triggers error', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await tester.enterText(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Contoh: Budi Setiawan'), 'Aldo Sebastian');
      await tester.enterText(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '16 digit angka KTP'), '1234567890123456');
      await tester.enterText(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'contoh@email.com'), 'invalidemail');
      await tester.pump();

      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();

      expect(find.text('Format email tidak valid (butuh @)'), findsWidgets);
    });

    testWidgets('F1_T2_4: Submit without selecting Kecamatan/Kelurahan displays error', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await tester.enterText(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Contoh: Budi Setiawan'), 'Aldo Sebastian');
      await tester.enterText(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '16 digit angka KTP'), '1234567890123456');
      await tester.enterText(find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'contoh@email.com'), 'test@example.com');
      await tester.pump();

      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();

      expect(find.text('Kecamatan belum dipilih'), findsWidgets);
    });

    testWidgets('F1_T2_5: Verifies input field limits length to exactly 16 digits for NIK', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      final nikField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == '16 digit angka KTP');
      await tester.enterText(nikField, '12345678901234567890');
      await tester.pump();

      // Should be limited to 16 characters
      final TextField textField = tester.widget(nikField);
      expect(textField.controller?.text.length, 16);
      expect(textField.controller?.text, '1234567890123456');
    });

    testWidgets('F2_T2_1: Verify toggle chip colors (selected vs unselected states)', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      // Find the unselected chip text 'Pelunasan Full'
      final pelunasanText = tester.widget<Text>(find.text('Pelunasan Full'));
      expect(pelunasanText.style?.color, const Color(0xFF707070));

      // Find selected chip 'Booking Unit'
      final bookingText = tester.widget<Text>(find.text('Booking Unit'));
      expect(bookingText.style?.color, Colors.white);
    });

    testWidgets('F2_T2_2: Toggle payment types repeatedly does not crash or leak state', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Pelunasan Full'));
        await tester.pump();
        await tester.tap(find.text('Booking Unit'));
        await tester.pump();
      }
      await tester.pumpAndSettle();
      expect(find.text('Booking Unit'), findsOneWidget);
    });

    testWidgets('F2_T2_3: Price formatting contains "Rp" and proper separators', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      expect(find.text('Rp 500.000'), findsWidgets);
    });

    testWidgets('F2_T2_4: Detail card sub-text changes dynamically depending on payment type', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      expect(find.text('Biaya untuk mengamankan antrian unit. Akan memotong harga OTR saat pelunasan nanti.'), findsOneWidget);

      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();

      expect(find.text('Pembayaran penuh untuk unit Honda Beat Sporty. Anda tidak perlu membayar lagi saat serah terima unit.'), findsOneWidget);
    });

    testWidgets('F2_T2_5: Guide info dialog can be successfully opened and closed', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      final infoButton = find.byIcon(Icons.info_outline);
      await tester.tap(infoButton);
      await tester.pumpAndSettle();

      expect(find.text('Panduan Pengisian Form'), findsOneWidget);

      await tester.tap(find.text('Tutup'));
      await tester.pumpAndSettle();

      expect(find.text('Panduan Pengisian Form'), findsNothing);
    });

    testWidgets('F3_T2_1: Submitting with empty Phone triggers error', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester, phone: '');

      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();

      expect(find.text('Nomor HP belum diisi'), findsWidgets);
    });

    testWidgets('F3_T2_2: Submitting with empty Alamat triggers error', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester, alamat: '');

      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();

      expect(find.text('Alamat belum diisi'), findsWidgets);
    });

    testWidgets('F3_T2_3: Validation errors are cleared immediately once valid data is provided', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();
      expect(find.text('Nama belum diisi'), findsWidgets);

      final nameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Contoh: Budi Setiawan');
      await tester.enterText(nameField, 'Aldo Sebastian');
      await tester.pumpAndSettle();

      expect(find.text('Nama belum diisi'), findsNothing);
    });

    testWidgets('F3_T2_4: Double-tapping checkout button quickly does not trigger duplicate navigation', (WidgetTester tester) async {
      int navigationCount = 0;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            navigationCount++;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester);

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(navigationCount, 1);
    });

    testWidgets('F3_T2_5: Navigating to payment summary and back retains form state', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => c.pop(),
              ),
            ),
            body: const Text('Summary'),
          )),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester);

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      // Tap back button in summary
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Aldo Sebastian'), findsOneWidget);
      expect(find.text('1234567890123456'), findsOneWidget);
    });
  });

  group('Tier 3: Cross-Feature Combinations', () {
    testWidgets('F1+F2: Form inputs remain populated and valid after changing the payment type', (WidgetTester tester) async {
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester);

      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Booking Unit'));
      await tester.pumpAndSettle();

      expect(find.text('Aldo Sebastian'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('F2+F3: Selected payment method details are correctly reflected in routing', (WidgetTester tester) async {
      bool? isFullPaymentPassed;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            final extra = s.extra as Map<String, dynamic>;
            isFullPaymentPassed = extra['isFullPayment'] as bool;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester);

      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(isFullPaymentPassed, isTrue);
    });

    testWidgets('F1+F3: Incomplete form fields prevent navigation, whereas a completed form routes correctly', (WidgetTester tester) async {
      bool routed = false;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            routed = true;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      // Submit incomplete form -> expect no navigation
      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();
      expect(routed, isFalse);

      // Fill remaining fields and submit -> expect navigation
      await fillForm(tester: tester);
      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(routed, isTrue);
    });
  });

  group('Tier 4: Real-World Workload Scenarios', () {
    testWidgets('Scenario 1: Standard Cash Booking Flow', (WidgetTester tester) async {
      bool routed = false;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            routed = true;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester);

      // Verify that "Booking Unit" is selected (default)
      expect(find.text('BIAYA RESERVASI (BOOKING)'), findsOneWidget);

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(routed, isTrue);
    });

    testWidgets('Scenario 2: Standard Full Payment Flow', (WidgetTester tester) async {
      bool routed = false;
      bool? isFullPaymentPassed;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            routed = true;
            final extra = s.extra as Map<String, dynamic>;
            isFullPaymentPassed = extra['isFullPayment'] as bool;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      await fillForm(tester: tester);

      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(routed, isTrue);
      expect(isFullPaymentPassed, isTrue);
    });

    testWidgets('Scenario 3: Input Correction Flow', (WidgetTester tester) async {
      bool routed = false;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            routed = true;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      // Submit with empty form to trigger "Nama belum diisi"
      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();
      expect(find.text('Nama belum diisi'), findsWidgets);

      // Correct the inputs step by step
      await fillForm(tester: tester);

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(routed, isTrue);
    });

    testWidgets('Scenario 4: Double Correction Flow', (WidgetTester tester) async {
      bool routed = false;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            routed = true;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      // Fill name only, trigger NIK error
      final nameField = find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText == 'Contoh: Budi Setiawan');
      await tester.enterText(nameField, 'Aldo Sebastian');
      await tester.pump();

      await tester.tap(find.text('Pilih Pembayaran Booking'));
      await tester.pumpAndSettle();
      expect(find.text('NIK harus minimal 15-16 digit'), findsWidgets);

      // Now fill all remaining correctly
      await fillForm(tester: tester, name: '');

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(routed, isTrue);
    });

    testWidgets('Scenario 5: Payment Comparison Flow', (WidgetTester tester) async {
      bool routed = false;
      bool? isFullPaymentPassed;
      final mockRouter = GoRouter(
        initialLocation: '/booking-form',
        routes: [
          GoRoute(path: '/booking-form', builder: (c, s) => const BookingFormPage(motor: dummyMotor)),
          GoRoute(path: '/ringkasan-pembayaran', builder: (c, s) {
            routed = true;
            final extra = s.extra as Map<String, dynamic>;
            isFullPaymentPassed = extra['isFullPayment'] as bool;
            return const Scaffold(body: Text('Summary'));
          }),
        ],
      );
      await tester.pumpWidget(createTestWidget(router: mockRouter));
      await tester.pumpAndSettle();

      // Check "Booking Unit" details
      expect(find.text('Rp 500.000'), findsWidgets);

      // Check "Pelunasan Full" details
      await tester.tap(find.text('Pelunasan Full'));
      await tester.pumpAndSettle();
      expect(find.text('18.000.000'), findsWidgets);

      // Go back to "Booking Unit"
      await tester.tap(find.text('Booking Unit'));
      await tester.pumpAndSettle();

      // Fill and submit
      await fillForm(tester: tester);

      final checkoutButton = find.text('Pilih Pembayaran Booking');
      await tester.ensureVisible(checkoutButton);
      await tester.tap(checkoutButton);
      await tester.pumpAndSettle();

      expect(routed, isTrue);
      expect(isFullPaymentPassed, isFalse);
    });
  });
}
