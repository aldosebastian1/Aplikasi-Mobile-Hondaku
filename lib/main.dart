import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'ui/core/theme.dart';
import 'ui/core/router.dart';
import 'data/seed_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await GoogleSignIn.instance.initialize();
    
    // UNCOMMENT LATER IF NEEDED: await seedFirestoreDatabase();
    // await seedFirestoreDatabase().then((_) {
    //   debugPrint("✅ SEEDING SELESAI");
    // });
  } catch (e) {
    debugPrint("⚠️ Initialization Error: $e");
    // We still want to run the app even if Firebase fails, 
    // to prevent the user from being stuck on a white screen.
  }
  
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hondaku',
      debugShowCheckedModeBanner: false,
      theme: HondakuTheme.lightTheme,
      darkTheme: HondakuTheme.darkTheme,
      themeMode: ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      routerConfig: goRouter,
    );
  }
}
