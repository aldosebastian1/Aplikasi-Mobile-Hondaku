import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/domain/models/motorcycle.dart';
import 'package:hondaku/ui/features/booking/views/booking_form_page.dart';
import 'package:hondaku/ui/features/booking/widgets/booking_payment_card.dart';

void main() {
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

  Widget createTestWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: BookingFormPage(motor: dummyMotor),
      ),
    );
  }

  testWidgets('BookingFormPage renders correctly and shows validation error on empty submit', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    
    // Tunggu sampai animasi/rendering awal selesai
    await tester.pumpAndSettle();

    // Verifikasi UI utama ter-render
    expect(find.text('Detail Pemesan'), findsOneWidget);
    expect(find.text('Honda Beat Sporty'), findsOneWidget);
    expect(find.byType(BookingPaymentCard), findsOneWidget);

    // Pastikan tombol checkout ada
    final submitButton = find.text('Pilih Pembayaran Booking');
    expect(submitButton, findsOneWidget);

    // Tap tombol checkout tanpa mengisi form (harus memunculkan SnackBar validasi)
    try {
      await tester.tap(submitButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500)); // Tunggu animasi SnackBar

      // Verifikasi pesan validasi muncul (karena textfield kosong)
      expect(find.text('Nama belum diisi'), findsWidgets);
      
      // Tunggu hingga toast selesai dan hilang agar tidak ada timer tersisa
      await tester.pump(const Duration(seconds: 3));
    } catch (e, stack) {
      print('TEST ERROR: $e');
      print(stack);
      rethrow;
    }
  });
}
