import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/models/motorcycle.dart';
import '../../home/view_models/home_view_model.dart';

class CatalogFilterState {
  final int selectedFilter;
  final String activeCategory;
  
  const CatalogFilterState({
    this.selectedFilter = 0,
    this.activeCategory = '',
  });
  
  CatalogFilterState copyWith({
    int? selectedFilter,
    String? activeCategory,
  }) {
    return CatalogFilterState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      activeCategory: activeCategory ?? this.activeCategory,
    );
  }
}

class CatalogFilterNotifier extends Notifier<CatalogFilterState> {
  @override
  CatalogFilterState build() => const CatalogFilterState();

  void setFilter(int filter) => state = state.copyWith(selectedFilter: filter);
  void setCategory(String category) => state = state.copyWith(activeCategory: category);
}

final catalogFilterProvider = NotifierProvider<CatalogFilterNotifier, CatalogFilterState>(CatalogFilterNotifier.new);

double _parsePrice(String priceString) {
  final cleanString = priceString.replaceAll(RegExp(r'[^0-9]'), '');
  return double.tryParse(cleanString) ?? 0.0;
}

final filteredCatalogMotorsProvider = Provider.family<List<Motorcycle>, List<Motorcycle>>((ref, motors) {
  final filterState = ref.watch(catalogFilterProvider);
  
  Iterable<Motorcycle> list = motors;
  if (filterState.activeCategory.isNotEmpty) {
    list = list.where((m) => m.categoryBadge.toUpperCase() == filterState.activeCategory.toUpperCase());
  }
  
  final result = list.toList();
  if (filterState.selectedFilter == 1) {
    result.sort((a, b) => _parsePrice(a.price).compareTo(_parsePrice(b.price)));
  } else if (filterState.selectedFilter == 2) {
    result.sort((a, b) => _parsePrice(b.price).compareTo(_parsePrice(a.price)));
  }
  return result;
});
