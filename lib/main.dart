import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'services/notifier/theme_notifier.dart';
import 'services/notifier/auth_notifier.dart';
import 'services/notifier/language_notifier.dart';
import 'utils/themes.dart';
import 'views/home/welcome_screen.dart';
import 'views/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('dataBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => AuthNotifier()),
        ChangeNotifierProvider(create: (_) => LanguageNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse Management System for Jatimas Inovasi',
      theme: themeApp,
      home: const WelcomeScreen(),
      routes: Routes.routes,
      supportedLocales: LocaleSetup.supportedLocales,
      localizationsDelegates: LocaleSetup.localizationsDelegates,
      localeResolutionCallback: LocaleSetup.localeResolutionCallback,
    );
  }
}

class LocaleSetup {
  static const Iterable<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      [
    FormBuilderLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static Locale? localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}
