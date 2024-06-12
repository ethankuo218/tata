import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tata/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      restorationScopeId: 'app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white, size: 18),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
          backgroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.black,
        ),
        primarySwatch: Colors.purple,
        fontFamily: "YuseiMagic",
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
