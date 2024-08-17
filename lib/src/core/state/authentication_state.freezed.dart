// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function() firstLogin,
    required TResult Function() otpSent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? firstLogin,
    TResult? Function()? otpSent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function()? firstLogin,
    TResult Function()? otpSent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UnAuthentication value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_FirstLogin value) firstLogin,
    required TResult Function(_OtpSent value) otpSent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UnAuthentication value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_FirstLogin value)? firstLogin,
    TResult? Function(_OtpSent value)? otpSent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UnAuthentication value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_FirstLogin value)? firstLogin,
    TResult Function(_OtpSent value)? otpSent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AuthenticationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function() firstLogin,
    required TResult Function() otpSent,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? firstLogin,
    TResult? Function()? otpSent,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function()? firstLogin,
    TResult Function()? otpSent,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UnAuthentication value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_FirstLogin value) firstLogin,
    required TResult Function(_OtpSent value) otpSent,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UnAuthentication value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_FirstLogin value)? firstLogin,
    TResult? Function(_OtpSent value)? otpSent,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UnAuthentication value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_FirstLogin value)? firstLogin,
    TResult Function(_OtpSent value)? otpSent,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthenticationState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AuthenticationState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function() firstLogin,
    required TResult Function() otpSent,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? firstLogin,
    TResult? Function()? otpSent,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function()? firstLogin,
    TResult Function()? otpSent,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UnAuthentication value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_FirstLogin value) firstLogin,
    required TResult Function(_OtpSent value) otpSent,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UnAuthentication value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_FirstLogin value)? firstLogin,
    TResult? Function(_OtpSent value)? otpSent,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UnAuthentication value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_FirstLogin value)? firstLogin,
    TResult Function(_OtpSent value)? otpSent,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AuthenticationState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$UnAuthenticationImplCopyWith<$Res> {
  factory _$$UnAuthenticationImplCopyWith(_$UnAuthenticationImpl value,
          $Res Function(_$UnAuthenticationImpl) then) =
      __$$UnAuthenticationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnAuthenticationImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$UnAuthenticationImpl>
    implements _$$UnAuthenticationImplCopyWith<$Res> {
  __$$UnAuthenticationImplCopyWithImpl(_$UnAuthenticationImpl _value,
      $Res Function(_$UnAuthenticationImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnAuthenticationImpl implements _UnAuthentication {
  const _$UnAuthenticationImpl();

  @override
  String toString() {
    return 'AuthenticationState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnAuthenticationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function() firstLogin,
    required TResult Function() otpSent,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? firstLogin,
    TResult? Function()? otpSent,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function()? firstLogin,
    TResult Function()? otpSent,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UnAuthentication value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_FirstLogin value) firstLogin,
    required TResult Function(_OtpSent value) otpSent,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UnAuthentication value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_FirstLogin value)? firstLogin,
    TResult? Function(_OtpSent value)? otpSent,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UnAuthentication value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_FirstLogin value)? firstLogin,
    TResult Function(_OtpSent value)? otpSent,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _UnAuthentication implements AuthenticationState {
  const factory _UnAuthentication() = _$UnAuthenticationImpl;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticatedImpl implements _Authenticated {
  const _$AuthenticatedImpl();

  @override
  String toString() {
    return 'AuthenticationState.authenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function() firstLogin,
    required TResult Function() otpSent,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? firstLogin,
    TResult? Function()? otpSent,
  }) {
    return authenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function()? firstLogin,
    TResult Function()? otpSent,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UnAuthentication value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_FirstLogin value) firstLogin,
    required TResult Function(_OtpSent value) otpSent,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UnAuthentication value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_FirstLogin value)? firstLogin,
    TResult? Function(_OtpSent value)? otpSent,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UnAuthentication value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_FirstLogin value)? firstLogin,
    TResult Function(_OtpSent value)? otpSent,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthenticationState {
  const factory _Authenticated() = _$AuthenticatedImpl;
}

/// @nodoc
abstract class _$$FirstLoginImplCopyWith<$Res> {
  factory _$$FirstLoginImplCopyWith(
          _$FirstLoginImpl value, $Res Function(_$FirstLoginImpl) then) =
      __$$FirstLoginImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FirstLoginImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$FirstLoginImpl>
    implements _$$FirstLoginImplCopyWith<$Res> {
  __$$FirstLoginImplCopyWithImpl(
      _$FirstLoginImpl _value, $Res Function(_$FirstLoginImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FirstLoginImpl implements _FirstLogin {
  const _$FirstLoginImpl();

  @override
  String toString() {
    return 'AuthenticationState.firstLogin()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FirstLoginImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function() firstLogin,
    required TResult Function() otpSent,
  }) {
    return firstLogin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? firstLogin,
    TResult? Function()? otpSent,
  }) {
    return firstLogin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function()? firstLogin,
    TResult Function()? otpSent,
    required TResult orElse(),
  }) {
    if (firstLogin != null) {
      return firstLogin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UnAuthentication value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_FirstLogin value) firstLogin,
    required TResult Function(_OtpSent value) otpSent,
  }) {
    return firstLogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UnAuthentication value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_FirstLogin value)? firstLogin,
    TResult? Function(_OtpSent value)? otpSent,
  }) {
    return firstLogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UnAuthentication value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_FirstLogin value)? firstLogin,
    TResult Function(_OtpSent value)? otpSent,
    required TResult orElse(),
  }) {
    if (firstLogin != null) {
      return firstLogin(this);
    }
    return orElse();
  }
}

abstract class _FirstLogin implements AuthenticationState {
  const factory _FirstLogin() = _$FirstLoginImpl;
}

/// @nodoc
abstract class _$$OtpSentImplCopyWith<$Res> {
  factory _$$OtpSentImplCopyWith(
          _$OtpSentImpl value, $Res Function(_$OtpSentImpl) then) =
      __$$OtpSentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpSentImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$OtpSentImpl>
    implements _$$OtpSentImplCopyWith<$Res> {
  __$$OtpSentImplCopyWithImpl(
      _$OtpSentImpl _value, $Res Function(_$OtpSentImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OtpSentImpl implements _OtpSent {
  const _$OtpSentImpl();

  @override
  String toString() {
    return 'AuthenticationState.otpSent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpSentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function() authenticated,
    required TResult Function() firstLogin,
    required TResult Function() otpSent,
  }) {
    return otpSent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function()? authenticated,
    TResult? Function()? firstLogin,
    TResult? Function()? otpSent,
  }) {
    return otpSent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function()? authenticated,
    TResult Function()? firstLogin,
    TResult Function()? otpSent,
    required TResult orElse(),
  }) {
    if (otpSent != null) {
      return otpSent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_UnAuthentication value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_FirstLogin value) firstLogin,
    required TResult Function(_OtpSent value) otpSent,
  }) {
    return otpSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_UnAuthentication value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_FirstLogin value)? firstLogin,
    TResult? Function(_OtpSent value)? otpSent,
  }) {
    return otpSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_UnAuthentication value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_FirstLogin value)? firstLogin,
    TResult Function(_OtpSent value)? otpSent,
    required TResult orElse(),
  }) {
    if (otpSent != null) {
      return otpSent(this);
    }
    return orElse();
  }
}

abstract class _OtpSent implements AuthenticationState {
  const factory _OtpSent() = _$OtpSentImpl;
}
