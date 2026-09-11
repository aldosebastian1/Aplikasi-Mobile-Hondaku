import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/domain/models/motorcycle.dart';
import 'package:hondaku/domain/models/leasing_parameter.dart';
import 'package:hondaku/data/providers.dart';
import 'package:hondaku/ui/features/kredit/views/simulasi_kredit_page.dart';

void main() {
  const mockMotor = Motorcycle(
    id: '1',
    name: 'Vario 160',
    subtitle: 'Brand New',
    price: 'Rp 26.000.000',
    imageAsset: 'assets/images/vario160.png',
    description: 'Motor sport matic tangguh.',
    categoryBadge: 'MATIC',
    engine: '160cc',
    maxPower: '15 HP',
    fuelCapacity: '5.5 L',
    features: [],
    specsMesin: {},
    specsRangka: {},
    specsDimensi: {},
  );

  testWidgets('SimulasiKreditPage rendering and calculation flow', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          leasingParametersProvider.overrideWith((ref) => Future.value([
            const LeasingParameter(
              id: '1',
              name: 'FIF Group',
              subtitle: 'Proses Cepat & Terpercaya',
              rateTahunan: 0.12,
              minDpPersen: 0.10,
              maxDpPersen: 0.75,
              tenorList: [11, 23, 35],
            ),
            const LeasingParameter(
              id: '2',
              name: 'Adira Finance',
              subtitle: 'Bunga Ringan',
              rateTahunan: 0.14,
              minDpPersen: 0.10,
              maxDpPersen: 0.75,
              tenorList: [11, 23, 35],
            ),
            const LeasingParameter(
              id: '3',
              name: 'BAF',
              subtitle: 'Pilihan Fleksibel',
              rateTahunan: 0.13,
              minDpPersen: 0.10,
              maxDpPersen: 0.75,
              tenorList: [11, 23, 35],
            ),
          ])),
        ],
        child: const MaterialApp(
          home: SimulasiKreditPage(motor: mockMotor),
        ),
      ),
    );

    // Settle initialization additions post frame callback
    await tester.pumpAndSettle();

    // Verify OTR price is rendered
    expect(find.text('Rp 26.000.000'), findsOneWidget); // Header OTR

    // Verify default DP (which is 10% by default, so Rp 2.600.000)
    expect(find.text('Rp 2.600.000'), findsOneWidget);

    // Drag slider to change DP percent (slider is fully visible on screen initially)
    final slider = find.byType(Slider);
    expect(slider, findsOneWidget);
    await tester.drag(slider, const Offset(150.0, 0.0));
    await tester.pumpAndSettle();
    
    // DP should change from original Rp 2.600.000
    expect(find.text('Rp 2.600.000'), findsNothing);

    // Verify Tenor choices (11, 23, 35) are visible
    expect(find.text('11'), findsOneWidget);
    expect(find.text('23'), findsOneWidget);
    expect(find.text('35'), findsOneWidget);

    // Tap tenor 23
    await tester.tap(find.text('23'));
    await tester.pumpAndSettle();

    // Scroll until FIF Group is visible
    final scrollable = find.byType(Scrollable);
    final fifGroup = find.text('FIF Group');
    await tester.scrollUntilVisible(fifGroup, 100.0, scrollable: scrollable);

    // Tap FIF Group leasing
    await tester.tap(fifGroup);
    await tester.pumpAndSettle();
  });
}
