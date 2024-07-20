import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/main.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/providers/pages/tarot-night/lobby_view_provider.dart'
    as lobby_view_provider;
import 'package:tata/src/core/providers/router_notifier.dart';
import 'package:tata/src/core/state/authentication_state.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/draw_card_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/draw_role_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/lobby_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/quest_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_info_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_list_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/test_result_view.dart';
import 'package:tata/src/ui/pages/chat-room/chat_room_view.dart';
import 'package:tata/src/ui/pages/walkthrough/walkthrough_view.dart';
import 'package:tata/src/ui/shared/pages/leave_chat_view.dart';
import 'package:tata/src/ui/shared/pages/members_view.dart';
import 'package:tata/src/ui/pages/chat-room-info/chat_room_info_view.dart';
import 'package:tata/src/ui/pages/home/home_view.dart';
import 'package:tata/src/ui/pages/auth/login_view.dart';
import 'package:tata/src/ui/pages/auth/phone_verify_input_page.dart';
import 'package:tata/src/ui/pages/auth/phone_verify_otp_page.dart';
import 'package:tata/src/ui/pages/realtime_pair/realtime_pair_view.dart';
import 'package:tata/src/ui/pages/settings/settings_view.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final routerListenable = ref.watch(routerNotifierProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/home',
    refreshListenable: routerListenable,
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
                chatRoomId: state.extra as String,
              ),
          routes: [
            GoRoute(
              path: ChatRoomInfoView.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  ChatRoomInfoView(chatRoomId: state.extra as String),
            ),
            GoRoute(
              path: MembersView.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  MembersView(
                      repository: 'chat_rooms', roomId: state.extra as String),
            ),
            GoRoute(
              path: LeaveChatView.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  LeaveChatView(chatRoomId: state.extra as String),
            ),
          ]),
      GoRoute(
          path: LoginView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginView()),
      GoRoute(
          path: WalkthroughView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const WalkthroughView()),
      GoRoute(
          path: PhoneVerifyInputView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const PhoneVerifyInputView()),
      GoRoute(
          path: PhoneVerifyOtpView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const PhoneVerifyOtpView()),
      GoRoute(
          path: TarotNightLobbyView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              const TarotNightLobbyView()),
      GoRoute(
          path: TarotNightRoomListView.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return const TarotNightRoomListView();
          }),
      GoRoute(
          path: TarotNightRoomView.routeName,
          builder: (BuildContext context, GoRouterState state) =>
              TarotNightRoomView(roomId: state.extra as String),
          routes: [
            GoRoute(
              path: TarotNightRoomInfoView.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  TarotNightRoomInfoView(
                      roomInfo: state.extra as TarotNightRoom),
            ),
            GoRoute(
              path: MembersView.routeName,
              builder: (BuildContext context, GoRouterState state) =>
                  MembersView(
                      repository: 'tarot_night_rooms',
                      roomId: state.extra as String),
            ),
          ]),
      GoRoute(
          path: TarotNightDrawCardView.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return TarotNightDrawCardView(
              roomId: (state.extra as dynamic)['roomId'] as String,
              question: (state.extra as dynamic)['question'] as String,
            );
          }),
      GoRoute(
          path: TarotNightDrawRoleView.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return TarotNightDrawRoleView(
              roomId: state.extra as String,
            );
          }),
      GoRoute(
          path: TarotNightTestResultView.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return TarotNightTestResultView(
              roomId: state.extra as String,
            );
          }),
      GoRoute(
          path: TarotNightQuestView.routeName,
          builder: (context, state) {
            return TarotNightQuestView(
              roomId: (state.extra as dynamic)['roomId'] as String,
              quest: (state.extra as dynamic)['quest'] as String,
            );
          }),
    ],
    redirect: (context, state) {
      switch (routerListenable.authState) {
        case const AuthenticationState.authenticated():
          return null;
        case const AuthenticationState.firstLogin():
          return WalkthroughView.routeName;
        case const AuthenticationState.unauthenticated():
          if (state.fullPath == PhoneVerifyInputView.routeName ||
              state.fullPath == PhoneVerifyOtpView.routeName) {
            return null;
          } else {
            ref.invalidate(lobby_view_provider.tarotNightLobbyViewProvider);
            return LoginView.routeName;
          }
        case const AuthenticationState.otpSent():
          return PhoneVerifyOtpView.routeName;
      }
      return null;
    },
  );
});
