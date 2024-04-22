import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tata/src/core/auth/data_source/auth_data_source.dart';
import 'package:tata/src/core/auth/providers/state/authentication_state.dart';

class AuthStateNotifier extends StateNotifier<AuthenticationState> {
  AuthStateNotifier(this._dataSource)
      : super(const AuthenticationState.initial());

  final AuthDataSource _dataSource;

// Sign in with Apple
  Future<void> signInWithApple() async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.signInWithApple();
    state = response.fold(
      (response) => AuthenticationState.authenticated(user: response),
      (error) => AuthenticationState.unauthenticated(message: error),
    );
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _dataSource.signInWithGoogle();
    state = response.fold(
      (response) => AuthenticationState.authenticated(user: response),
      (error) => AuthenticationState.unauthenticated(message: error),
    );
  }

  // Sign in with Phone Number
  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    state = const AuthenticationState.loading();
    final response =
        await _dataSource.signInWithPhoneNumber(verificationId, smsCode);
    state = response.fold(
      (response) => AuthenticationState.authenticated(user: response),
      (error) => AuthenticationState.unauthenticated(message: error),
    );
  }

  // Sign out
  Future<void> signOut() async {
    state = const AuthenticationState.loading();
    await _dataSource.signOut();
    state = const AuthenticationState.initial();
  }
}

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthenticationState>(
  (ref) => AuthStateNotifier(ref.read(authDataSourceProvider)),
);
