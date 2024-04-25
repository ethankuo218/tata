import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tata/src/core/repositories/auth_repository.dart';
import 'package:tata/src/core/state/authentication_state.dart';

class AuthStateNotifier extends StateNotifier<AuthenticationState> {
  AuthStateNotifier(this._authRepository)
      : super(const AuthenticationState.initial());

  final AuthRepository _authRepository;

  // Sign in with Apple
  Future<void> signInWithApple() async {
    state = const AuthenticationState.loading();
    final response = await _authRepository.signInWithApple();
    state = response.fold(
      (response) => AuthenticationState.authenticated(user: response),
      (error) => AuthenticationState.unauthenticated(message: error),
    );
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _authRepository.signInWithGoogle();
    state = response.fold(
      (response) => AuthenticationState.authenticated(user: response),
      (error) => AuthenticationState.unauthenticated(message: error),
    );
  }

  // Sign in with Phone Number
  Future<void> sendOtp(BuildContext context, PhoneNumber phoneNumber) async {
    state = const AuthenticationState.loading();
    final response = await _authRepository.sendOtp(context, phoneNumber);
    state = response.fold(
      (response) => const AuthenticationState.otpSent(),
      (error) => AuthenticationState.unauthenticated(message: error),
    );
  }

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    state = const AuthenticationState.loading();
    final response =
        await _authRepository.signInWithPhoneNumber(verificationId, smsCode);
    state = response.fold(
      (response) => AuthenticationState.authenticated(user: response),
      (error) => AuthenticationState.unauthenticated(message: error),
    );
  }

  // Resend Otp
  Future<void> resendOtp(PhoneNumber phoneNumber) async {
    state = const AuthenticationState.loading();
    final response = await _authRepository.resendOtp(phoneNumber);
    state = response.fold(
      (response) => const AuthenticationState.otpSent(),
      (error) => AuthenticationState.unauthenticated(message: error),
    );
  }

  // Sign out
  Future<void> signOut() async {
    state = const AuthenticationState.loading();
    await _authRepository.signOut();
    state = const AuthenticationState.initial();
  }
}

final authProvider =
    StateNotifierProvider<AuthStateNotifier, AuthenticationState>(
  (ref) => AuthStateNotifier(ref.read(authRepositoryProvider)),
);
