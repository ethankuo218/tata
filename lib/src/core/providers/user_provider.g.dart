// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userHash() => r'a4072cd5ea2efd6f87336221e21718f0abab38b9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$User extends BuildlessAutoDisposeAsyncNotifier<AppUserInfo?> {
  late final String? uid;

  FutureOr<AppUserInfo?> build(
    String? uid,
  );
}

/// See also [User].
@ProviderFor(User)
const userProvider = UserFamily();

/// See also [User].
class UserFamily extends Family<AsyncValue<AppUserInfo?>> {
  /// See also [User].
  const UserFamily();

  /// See also [User].
  UserProvider call(
    String? uid,
  ) {
    return UserProvider(
      uid,
    );
  }

  @override
  UserProvider getProviderOverride(
    covariant UserProvider provider,
  ) {
    return call(
      provider.uid,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProvider';
}

/// See also [User].
class UserProvider
    extends AutoDisposeAsyncNotifierProviderImpl<User, AppUserInfo?> {
  /// See also [User].
  UserProvider(
    String? uid,
  ) : this._internal(
          () => User()..uid = uid,
          from: userProvider,
          name: r'userProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
          dependencies: UserFamily._dependencies,
          allTransitiveDependencies: UserFamily._allTransitiveDependencies,
          uid: uid,
        );

  UserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String? uid;

  @override
  FutureOr<AppUserInfo?> runNotifierBuild(
    covariant User notifier,
  ) {
    return notifier.build(
      uid,
    );
  }

  @override
  Override overrideWith(User Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserProvider._internal(
        () => create()..uid = uid,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<User, AppUserInfo?> createElement() {
    return _UserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserRef on AutoDisposeAsyncNotifierProviderRef<AppUserInfo?> {
  /// The parameter `uid` of this provider.
  String? get uid;
}

class _UserProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<User, AppUserInfo?>
    with UserRef {
  _UserProviderElement(super.provider);

  @override
  String? get uid => (origin as UserProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
