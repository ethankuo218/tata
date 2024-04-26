import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/repositories/auth_repository.dart';
import 'package:tata/src/core/state/authentication_state.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  String? _verificationId;
  PhoneNumber? _phoneNumber;

  PhoneNumber? get phoneNumber => _phoneNumber;

  Auth() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      print(user);
      if (user != null) {
        state = const AuthenticationState.authenticated();
      } else {
        state = const AuthenticationState.unauthenticated();
      }
    });
  }

  @override
  AuthenticationState build() {
    state = const AuthenticationState.initial();
    return state;
  }

  // Sign in with Apple
  Future<void> signInWithApple() async {
    await ref.read(authRepositoryProvider).signInWithApple();
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    await ref.read(authRepositoryProvider).signInWithGoogle();
  }

  // Sign in with Phone Number
  Future<void> sendOtp(PhoneNumber phoneNumber) async {
    ref.read(authRepositoryProvider).sendOtp(phoneNumber).then((value) {
      _verificationId = value.fold((l) => l, (r) => r);
      _phoneNumber = phoneNumber;

      if (_verificationId == 'Unknown Error') {
        state = const AuthenticationState.unauthenticated();
        return;
      }

      state = const AuthenticationState.otpSent();
    });
  }

  void signInWithPhoneNumber(String smsCode) {
    ref
        .read(authRepositoryProvider)
        .signInWithPhoneNumber(_verificationId!, smsCode);
  }

  // Resend Otp
  Future<void> resendOtp() async {
    final response =
        await ref.read(authRepositoryProvider).resendOtp(_phoneNumber!);
    state = response.fold(
      (response) => const AuthenticationState.otpSent(),
      (error) => const AuthenticationState.unauthenticated(),
    );
  }

  // Sign out
  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}
