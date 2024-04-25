// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$membersHash() => r'096ac3b3efecca168f893988508dc3af1250a700';

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

abstract class _$Members
    extends BuildlessAutoDisposeAsyncNotifier<List<AppUserInfo>> {
  late final List<String> uidList;

  FutureOr<List<AppUserInfo>> build(
    List<String> uidList,
  );
}

/// See also [Members].
@ProviderFor(Members)
const membersProvider = MembersFamily();

/// See also [Members].
class MembersFamily extends Family<AsyncValue<List<AppUserInfo>>> {
  /// See also [Members].
  const MembersFamily();

  /// See also [Members].
  MembersProvider call(
    List<String> uidList,
  ) {
    return MembersProvider(
      uidList,
    );
  }

  @override
  MembersProvider getProviderOverride(
    covariant MembersProvider provider,
  ) {
    return call(
      provider.uidList,
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
  String? get name => r'membersProvider';
}

/// See also [Members].
class MembersProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Members, List<AppUserInfo>> {
  /// See also [Members].
  MembersProvider(
    List<String> uidList,
  ) : this._internal(
          () => Members()..uidList = uidList,
          from: membersProvider,
          name: r'membersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$membersHash,
          dependencies: MembersFamily._dependencies,
          allTransitiveDependencies: MembersFamily._allTransitiveDependencies,
          uidList: uidList,
        );

  MembersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uidList,
  }) : super.internal();

  final List<String> uidList;

  @override
  FutureOr<List<AppUserInfo>> runNotifierBuild(
    covariant Members notifier,
  ) {
    return notifier.build(
      uidList,
    );
  }

  @override
  Override overrideWith(Members Function() create) {
    return ProviderOverride(
      origin: this,
      override: MembersProvider._internal(
        () => create()..uidList = uidList,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uidList: uidList,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Members, List<AppUserInfo>>
      createElement() {
    return _MembersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MembersProvider && other.uidList == uidList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uidList.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MembersRef on AutoDisposeAsyncNotifierProviderRef<List<AppUserInfo>> {
  /// The parameter `uidList` of this provider.
  List<String> get uidList;
}

class _MembersProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Members, List<AppUserInfo>>
    with MembersRef {
  _MembersProviderElement(super.provider);

  @override
  List<String> get uidList => (origin as MembersProvider).uidList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
