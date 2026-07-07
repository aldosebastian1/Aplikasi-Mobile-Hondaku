import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'ui/core/theme.dart';
import 'ui/core/router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'ui/features/profile/view_models/profile_view_model.dart';
// import 'scripts/seed_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await GoogleSignIn.instance.initialize();

    // await seedFirestoreDatabase().then((_) {
    //   debugPrint("✅ MIGRASI OTOMATIS SELESAI");
    // });
  } catch (e) {
    debugPrint("⚠️ Initialization Error: $e");
    // We still want to run the app even if Firebase fails,
    // to prevent the user from being stuck on a white screen.
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch app settings to listen for language/theme changes
    final appSettings = ref.watch(appSettingsProvider);
    final locale = appSettings.selectedLanguage == 'English'
        ? const Locale('en')
        : const Locale('id');

    return MaterialApp.router(
      title: 'Hondaku',
      debugShowCheckedModeBanner: false,
      theme: HondakuTheme.lightTheme,
      themeMode: ThemeMode.light,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('id')],
      routerConfig: goRouter,
    );
  }
}
