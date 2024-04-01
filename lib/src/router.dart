import 'package:flutter/material.dart';
import 'package:tata/src/chat-room/chat_room_page.dart';
import 'package:tata/src/home/home_page.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/models/phone_verify_argument.dart';
import 'package:tata/src/phone-verify/phone_verify_input_page.dart';
import 'package:tata/src/phone-verify/phone_verify_otp_page.dart';
import 'package:tata/src/services/auth/auth_gate.dart';
import 'package:tata/src/settings/settings_controller.dart';
import 'package:tata/src/settings/settings_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(
      RouteSettings settings, SettingsController settingsController) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case ChatRoomPage.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                ChatRoomPage(chatRoomInfo: settings.arguments as ChatRoom));
      case PhoneVerifyInputPage.routeName:
        return MaterialPageRoute(builder: (_) => const PhoneVerifyInputPage());
      case PhoneVerifyOtpPage.routeName:
        final args = settings.arguments as PhoneVerifyArgument;
        return MaterialPageRoute(
            builder: (_) => PhoneVerifyOtpPage(args: args));
      case SettingsView.routeName:
        return MaterialPageRoute(
            builder: (_) => SettingsView(controller: settingsController));
      case AuthGate.routeName:
      default:
        return MaterialPageRoute(builder: (_) => const AuthGate());
    }
  }
}
