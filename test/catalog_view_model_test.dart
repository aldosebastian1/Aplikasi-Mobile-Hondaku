import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/domain/models/motorcycle.dart';
import 'package:hondaku/ui/features/catalog/view_models/catalog_view_model.dart';
import 'package:hondaku/ui/features/home/view_models/home_view_model.dart';

void main() {
  final List<Motorcycle> mockMotors = [
    const Motorcycle(
      id: '1',
      name: 'Honda Beat',
      subtitle: 'Matic',
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
    ),
    const Motorcycle(
      id: '2',
      name: 'Honda CBR150R',
      subtitle: 'Sport',
      description: 'Desc',
      price: 'Rp 37.000.000',
      imageAsset: 'test2.jpg',
      categoryBadge: 'SPORT',
      engine: '150cc',
      maxPower: '17 HP',
      fuelCapacity: '12L',
      features: [],
      specsMesin: {},
      specsRangka: {},
      specsDimensi: {},
    ),
    const Motorcycle(
      id: '3',
      name: 'Honda Vario 160',
      subtitle: 'Matic',
      description: 'Desc',
      price: 'Rp 27.000.000',
      imageAsset: 'test3.jpg',
      categoryBadge: 'MATIC',
      engine: '160cc',
      maxPower: '15 HP',
      fuelCapacity: '5.5L',
      features: [],
      specsMesin: {},
      specsRangka: {},
      specsDimensi: {},
    ),
  ];

  test('CatalogFilterNotifier updates state correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Initial state
    final initialState = container.read(catalogFilterProvider);
    expect(initialState.selectedFilter, 0);
    expect(initialState.activeCategory, '');

    // Set category
    container.read(catalogFilterProvider.notifier).setCategory('MATIC');
    expect(container.read(catalogFilterProvider).activeCategory, 'MATIC');

    // Set filter (sort)
    container.read(catalogFilterProvider.notifier).setFilter(1);
    expect(container.read(catalogFilterProvider).selectedFilter, 1);
  });

  test('filteredCatalogMotorsProvider filters and sorts data correctly', () async {
    final container = ProviderContainer(
      overrides: [
        homeMotorcyclesProvider.overrideWith((ref) => mockMotors),
      ],
    );
    addTearDown(container.dispose);

    // Default: no filter, no sort (returns all 3)
    var result = container.read(filteredCatalogMotorsProvider);
    expect(result.length, 3);

    // Set category to MATIC
    container.read(catalogFilterProvider.notifier).setCategory('MATIC');
    result = container.read(filteredCatalogMotorsProvider);
    expect(result.length, 2);
    expect(result.any((m) => m.name == 'Honda CBR150R'), false);

    // Clear category, Sort by Price (Lowest First) -> selectedFilter = 1
    container.read(catalogFilterProvider.notifier).setCategory('');
    container.read(catalogFilterProvider.notifier).setFilter(1);
    result = container.read(filteredCatalogMotorsProvider);
    expect(result.length, 3);
    // 18jt, 27jt, 37jt
    expect(result[0].name, 'Honda Beat');
    expect(result[1].name, 'Honda Vario 160');
    expect(result[2].name, 'Honda CBR150R');

    // Sort by Price (Highest First) -> selectedFilter = 2
    container.read(catalogFilterProvider.notifier).setFilter(2);
    result = container.read(filteredCatalogMotorsProvider);
    // 37jt, 27jt, 18jt
    expect(result[0].name, 'Honda CBR150R');
    expect(result[1].name, 'Honda Vario 160');
    expect(result[2].name, 'Honda Beat');
  });
}
