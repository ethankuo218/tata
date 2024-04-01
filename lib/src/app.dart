import 'package:tata/src/router.dart';
import 'package:tata/src/services/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class App extends StatelessWidget {
  const App({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
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
              backgroundColor: Colors.black,
            ),
            scaffoldBackgroundColor: Colors.black,
            bottomSheetTheme: const BottomSheetThemeData(
              surfaceTintColor: Colors.black,
            ),
            primarySwatch: Colors.purple,
            fontFamily: "YuseiMagic",
          ),

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) =>
              AppRouter.generateRoute(
            routeSettings,
            settingsController,
          ),
          initialRoute: AuthGate.routeName,
        );
      },
    );
  }
}
