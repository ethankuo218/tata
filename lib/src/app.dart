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
          iconTheme: IconThemeData(color: Colors.white, size: 16),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 17),
          backgroundColor: Color.fromARGB(255, 7, 9, 47),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 7, 9, 47),
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Color.fromARGB(255, 7, 9, 47),
        ),
        primarySwatch: const MaterialColor(
          0xFFFFE455,
          <int, Color>{
            50: Color(0xFFFFE455),
            100: Color(0xFFFFE455),
            200: Color(0xFFFFE455),
            300: Color(0xFFFFE455),
            400: Color(0xFFFFE455),
            500: Color(0xFFFFE455),
            600: Color(0xFFFFE455),
            700: Color(0xFFFFE455),
            800: Color(0xFFFFE455),
            900: Color(0xFFFFE455),
          },
        ),
        fontFamily: "YuPearl",
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 255, 228, 85),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                height: 1.0,
                color: Color.fromARGB(255, 7, 9, 47),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
