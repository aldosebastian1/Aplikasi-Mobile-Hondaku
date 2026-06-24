import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hondaku/domain/models/motorcycle.dart';
import 'package:hondaku/ui/core/widgets/motorcycle_card_widget.dart';
import 'package:hondaku/ui/features/home/widgets/home_search_bar.dart';
import 'package:hondaku/ui/features/home/widgets/home_category_selector.dart';
import 'package:hondaku/l10n/app_localizations.dart';

@Preview(name: 'Motorcycle Card Preview', group: 'Cards')
Widget previewMotorcycleCard() {
  const mockMotor = Motorcycle(
    id: '1',
    name: 'CBR250RR',
    subtitle: 'Total Control',
    price: 'Rp 62.800.000',
    imageAsset: 'assets/images/cbr250rr.png',
    description: 'Sensasi berkendara kelas dunia dengan performa mesin 250cc twin silinder.',
    categoryBadge: 'SPORT',
    engine: '250cc, 2-Cylinder',
    maxPower: '38.2 HP',
    fuelCapacity: '14.5 L',
    features: [],
    specsMesin: {
      'Tipe Mesin': '4-Stroke, 8-Valve, Parallel Twin Cylinder',
      'Kapasitas': '249.7 cc',
    },
    specsRangka: {
      'Tipe Rangka': 'Diamond (Truss)',
    },
    specsDimensi: {
      'Panjang x Lebar x Tinggi': '2.060 x 724 x 1.098 mm',
    },
  );

  return const ProviderScope(
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('id'),
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: MotorcycleCardWidget(motor: mockMotor),
        ),
      ),
    ),
  );
}

@Preview(name: 'Home Search Bar Preview', group: 'Navigation')
Widget previewSearchBar() {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('id'),
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HomeSearchBar(
          controller: TextEditingController(),
          searchQuery: '',
          onChanged: (_) {},
          onClear: () {},
        ),
      ),
    ),
  );
}

@Preview(name: 'Category Selector Preview', group: 'Selectors')
Widget previewCategorySelector() {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('id'),
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HomeCategorySelector(
          selectedCategory: 'SPORT',
          onCategorySelected: (_) {},
        ),
      ),
    ),
  );
}
