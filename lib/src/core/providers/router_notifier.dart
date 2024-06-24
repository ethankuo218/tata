import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/providers/auth_provider.dart';
import 'package:tata/src/core/state/authentication_state.dart';

part 'router_notifier.g.dart';

class RouterNotifier extends ChangeNotifier {
  late AuthenticationState _authState = const AuthenticationState.initial();
  RouterNotifier(RouterNotifierRef ref) {
    ref.watch(authProvider).when(
          initial: () => authState = const AuthenticationState.initial(),
          loading: () => authState = const AuthenticationState.loading(),
          unauthenticated: () =>
              authState = const AuthenticationState.unauthenticated(),
          authenticated: () =>
              authState = const AuthenticationState.authenticated(),
          firstLogin: () => authState = const AuthenticationState.firstLogin(),
          otpSent: () => authState = const AuthenticationState.otpSent(),
        );
  }

  AuthenticationState get authState => _authState;

  set authState(AuthenticationState value) {
    _authState = value;
    notifyListeners();
  }
}

@Riverpod(keepAlive: true)
RouterNotifier routerNotifier(RouterNotifierRef ref) => RouterNotifier(ref);
