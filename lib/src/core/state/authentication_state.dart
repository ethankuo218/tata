import 'package:freezed_annotation/freezed_annotation.dart';

part "authentication_state.freezed.dart";

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _Initial;

  const factory AuthenticationState.loading() = _Loading;

  const factory AuthenticationState.unauthenticated() = _UnAuthentication;

  const factory AuthenticationState.authenticated() = _Authenticated;

  const factory AuthenticationState.firstLogin() = _FirstLogin;

  const factory AuthenticationState.otpSent() = _OtpSent;
}
