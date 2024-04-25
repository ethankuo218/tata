import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/providers/authentication_provider.dart';
import 'package:tata/src/ui/shared/pages/chat-room/chat_room_controller.dart';
import 'package:tata/src/ui/shared/pages/chat-room/chat_room_view.dart';
import 'package:tata/src/ui/shared/pages/chat-room/components/leave_chat_view.dart';
import 'package:tata/src/ui/shared/pages/chat-room/components/members_view.dart';
import 'package:tata/src/ui/shared/pages/chat-room/components/room_info_view.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/models/route_argument.dart';
import 'package:tata/src/ui/pages/home/home_view.dart';
import 'package:tata/src/ui/pages/auth/login_view.dart';
import 'package:tata/src/ui/pages/auth/phone_verify_input_page.dart';
import 'package:tata/src/ui/pages/auth/phone_verify_otp_page.dart';
import 'package:tata/src/ui/pages/realtime_pair/realtime_pair_view.dart';
import 'package:tata/src/ui/pages/settings/settings_view.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authenticationProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: '/home',
    refreshListenable: authState,
    routes: <RouteBase>[
      GoRoute(
          path: HomeView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const HomeView()),
      GoRoute(
          path: SettingsView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const SettingsView()),
      GoRoute(
          path: RealtimePairView.routeName,
          builder: (context, state) => const RealtimePairView()),
      GoRoute(
          path: ChatRoomView.routeName,
          builder: (BuildContext context, GoRouterState state) => ChatRoomView(
                args: state.extra as ChatRoomArgument,
                controller: ChatRoomController(state.extra as ChatRoomArgument),
              ),
          routes: [
            GoRoute(
              path: RoomInfoView.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  RoomInfoView(chatRoomInfo: state.extra as ChatRoom),
            ),
            GoRoute(
              path: MembersView.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  MembersView(chatRoomInfo: state.extra as ChatRoom),
            ),
            GoRoute(
              path: LeaveChatView.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  LeaveChatView(chatRoomId: state.extra as String),
            ),
          ]),
      GoRoute(
          path: LoginView.routeName,
          builder: (context, state) => const LoginView()),
      GoRoute(
          path: PhoneVerifyInputView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const PhoneVerifyInputView()),
      GoRoute(
          path: PhoneVerifyOtpView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              PhoneVerifyOtpView(args: state.extra as PhoneVerifyArgument))
    ],
    redirect: (context, state) {
      if (state.fullPath == PhoneVerifyInputView.routeName ||
          state.fullPath == PhoneVerifyOtpView.routeName) {
        return null;
      }

      return authState.isAuthenticated ? null : LoginView.routeName;
    },
  );
});
