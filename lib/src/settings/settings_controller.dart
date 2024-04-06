import 'package:share_plus/share_plus.dart';
import 'package:tata/src/models/app_user_info.dart';
import 'package:tata/src/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/services/user.service.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../services/auth/auth_gate.dart';
import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  late AppUserInfo _userInfo;

  AppUserInfo get userInfo => _userInfo;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> loadUserInfo(String uid) async {
    _userInfo = await UserService().getUserInfo(uid);
    notifyListeners();
  }

  Future<void> editName(String uid, String name) async {
    try {
      await UserService().editUserInfo(uid: uid, name: name);
      await loadUserInfo(uid);
    } catch (e) {
      print(e);
    }
  }

  void openHelpCenter() {
    launchUrlString('mailto:support@tatrot.app');
  }

  void openInviteFriends() {
    Share.share(
        'Hi! Join TATA to enjoy the most incredible anonymous chat activity: MIDNIGHT TAROT !');
  }

  void openTermsAndConditions() {
    launchUrlString('Terms & Conditions');
  }

  void openPrivacyPolicy() {
    launchUrlString('Privacy Policy');
  }

  void signOut(BuildContext context) {
    AuthService().signOut().then((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AuthGate()));
    });
  }
}
