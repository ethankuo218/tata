import 'package:flutter/material.dart';
import 'package:tata/src/chat-room/chat_room_controller.dart';
import 'package:tata/src/chat-room/chat_room_view.dart';
import 'package:tata/src/chat-room/components/leave_chat_page.dart';
import 'package:tata/src/chat-room/components/members_page.dart';
import 'package:tata/src/chat-room/components/room_info_page.dart';
import 'package:tata/src/home/home_page.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/models/route_argument.dart';
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
      case ChatRoomView.routeName:
        return MaterialPageRoute(
            builder: (_) => ChatRoomView(
                  args: settings.arguments as ChatRoomArgument,
                  controller: ChatRoomController(),
                ));
      case RoomInfoPage.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                RoomInfoPage(chatRoomInfo: settings.arguments as ChatRoom));
      case MembersPage.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                MembersPage(chatRoomInfo: settings.arguments as ChatRoom));
      case LeaveChatPage.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                LeaveChatPage(chatRoomId: settings.arguments as String));
      case PhoneVerifyInputPage.routeName:
        return MaterialPageRoute(builder: (_) => const PhoneVerifyInputPage());
      case PhoneVerifyOtpPage.routeName:
        return MaterialPageRoute(
            builder: (_) => PhoneVerifyOtpPage(
                args: settings.arguments as PhoneVerifyArgument));
      case SettingsView.routeName:
        return MaterialPageRoute(
            builder: (_) => SettingsView(controller: settingsController));
      case AuthGate.routeName:
      default:
        return MaterialPageRoute(builder: (_) => const AuthGate());
    }
  }
}
