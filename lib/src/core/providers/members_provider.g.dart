// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$membersHash() => r'0b639cf83412a740d7e8046cdb03449862f8fba3';

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
    extends BuildlessAutoDisposeAsyncNotifier<List<Member>> {
  late final String repository;
  late final String roomId;

  FutureOr<List<Member>> build({
    required String repository,
    required String roomId,
  });
}

/// See also [Members].
@ProviderFor(Members)
const membersProvider = MembersFamily();

/// See also [Members].
class MembersFamily extends Family<AsyncValue<List<Member>>> {
  /// See also [Members].
  const MembersFamily();

  /// See also [Members].
  MembersProvider call({
    required String repository,
    required String roomId,
  }) {
    return MembersProvider(
      repository: repository,
      roomId: roomId,
    );
  }

  @override
  MembersProvider getProviderOverride(
    covariant MembersProvider provider,
  ) {
    return call(
      repository: provider.repository,
      roomId: provider.roomId,
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
    extends AutoDisposeAsyncNotifierProviderImpl<Members, List<Member>> {
  /// See also [Members].
  MembersProvider({
    required String repository,
    required String roomId,
  }) : this._internal(
          () => Members()
            ..repository = repository
            ..roomId = roomId,
          from: membersProvider,
          name: r'membersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$membersHash,
          dependencies: MembersFamily._dependencies,
          allTransitiveDependencies: MembersFamily._allTransitiveDependencies,
          repository: repository,
          roomId: roomId,
        );

  MembersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.repository,
    required this.roomId,
  }) : super.internal();

  final String repository;
  final String roomId;

  @override
  FutureOr<List<Member>> runNotifierBuild(
    covariant Members notifier,
  ) {
    return notifier.build(
      repository: repository,
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(Members Function() create) {
    return ProviderOverride(
      origin: this,
      override: MembersProvider._internal(
        () => create()
          ..repository = repository
          ..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        repository: repository,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Members, List<Member>>
      createElement() {
    return _MembersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MembersProvider &&
        other.repository == repository &&
        other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, repository.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MembersRef on AutoDisposeAsyncNotifierProviderRef<List<Member>> {
  /// The parameter `repository` of this provider.
  String get repository;

  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _MembersProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Members, List<Member>>
    with MembersRef {
  _MembersProviderElement(super.provider);

  @override
  String get repository => (origin as MembersProvider).repository;
  @override
  String get roomId => (origin as MembersProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
