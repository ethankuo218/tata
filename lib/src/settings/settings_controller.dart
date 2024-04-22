import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tata/src/core/auth/providers/auth_state_provider.dart';
import 'package:tata/src/models/app_user_info.dart';
import 'package:tata/src/services/user.service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsController {
  SettingsController();

  late AppUserInfo _userInfo;

  AppUserInfo get userInfo => _userInfo;

  Future<void> loadUserInfo(String uid) async {
    _userInfo = await UserService().getUserInfo(uid);
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

  void signOut(WidgetRef ref) {
    ref.read(authStateProvider.notifier).signOut();
  }
}
