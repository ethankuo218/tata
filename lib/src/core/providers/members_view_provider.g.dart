// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$membersViewHash() => r'74289d71291c65680104623008a7e87fd16ec4f9';

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

abstract class _$MembersView
    extends BuildlessAutoDisposeAsyncNotifier<List<MemberInfo>> {
  late final String repository;
  late final String roomId;

  FutureOr<List<MemberInfo>> build({
    required String repository,
    required String roomId,
  });
}

/// See also [MembersView].
@ProviderFor(MembersView)
const membersViewProvider = MembersViewFamily();

/// See also [MembersView].
class MembersViewFamily extends Family<AsyncValue<List<MemberInfo>>> {
  /// See also [MembersView].
  const MembersViewFamily();

  /// See also [MembersView].
  MembersViewProvider call({
    required String repository,
    required String roomId,
  }) {
    return MembersViewProvider(
      repository: repository,
      roomId: roomId,
    );
  }

  @override
  MembersViewProvider getProviderOverride(
    covariant MembersViewProvider provider,
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
  String? get name => r'membersViewProvider';
}

/// See also [MembersView].
class MembersViewProvider extends AutoDisposeAsyncNotifierProviderImpl<
    MembersView, List<MemberInfo>> {
  /// See also [MembersView].
  MembersViewProvider({
    required String repository,
    required String roomId,
  }) : this._internal(
          () => MembersView()
            ..repository = repository
            ..roomId = roomId,
          from: membersViewProvider,
          name: r'membersViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$membersViewHash,
          dependencies: MembersViewFamily._dependencies,
          allTransitiveDependencies:
              MembersViewFamily._allTransitiveDependencies,
          repository: repository,
          roomId: roomId,
        );

  MembersViewProvider._internal(
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
  FutureOr<List<MemberInfo>> runNotifierBuild(
    covariant MembersView notifier,
  ) {
    return notifier.build(
      repository: repository,
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(MembersView Function() create) {
    return ProviderOverride(
      origin: this,
      override: MembersViewProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<MembersView, List<MemberInfo>>
      createElement() {
    return _MembersViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MembersViewProvider &&
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

mixin MembersViewRef on AutoDisposeAsyncNotifierProviderRef<List<MemberInfo>> {
  /// The parameter `repository` of this provider.
  String get repository;

  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _MembersViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MembersView,
        List<MemberInfo>> with MembersViewRef {
  _MembersViewProviderElement(super.provider);

  @override
  String get repository => (origin as MembersViewProvider).repository;
  @override
  String get roomId => (origin as MembersViewProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
