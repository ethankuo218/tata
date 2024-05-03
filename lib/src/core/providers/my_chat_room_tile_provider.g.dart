// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_chat_room_tile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myChatRoomTileHash() => r'd8df6fa600b912e7e86f6f9e2fb8361f725f9fe5';

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

abstract class _$MyChatRoomTile
    extends BuildlessAutoDisposeAsyncNotifier<Member?> {
  late final String chatRoomId;

  FutureOr<Member?> build({
    required String chatRoomId,
  });
}

/// See also [MyChatRoomTile].
@ProviderFor(MyChatRoomTile)
const myChatRoomTileProvider = MyChatRoomTileFamily();

/// See also [MyChatRoomTile].
class MyChatRoomTileFamily extends Family<AsyncValue<Member?>> {
  /// See also [MyChatRoomTile].
  const MyChatRoomTileFamily();

  /// See also [MyChatRoomTile].
  MyChatRoomTileProvider call({
    required String chatRoomId,
  }) {
    return MyChatRoomTileProvider(
      chatRoomId: chatRoomId,
    );
  }

  @override
  MyChatRoomTileProvider getProviderOverride(
    covariant MyChatRoomTileProvider provider,
  ) {
    return call(
      chatRoomId: provider.chatRoomId,
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
  String? get name => r'myChatRoomTileProvider';
}

/// See also [MyChatRoomTile].
class MyChatRoomTileProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MyChatRoomTile, Member?> {
  /// See also [MyChatRoomTile].
  MyChatRoomTileProvider({
    required String chatRoomId,
  }) : this._internal(
          () => MyChatRoomTile()..chatRoomId = chatRoomId,
          from: myChatRoomTileProvider,
          name: r'myChatRoomTileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myChatRoomTileHash,
          dependencies: MyChatRoomTileFamily._dependencies,
          allTransitiveDependencies:
              MyChatRoomTileFamily._allTransitiveDependencies,
          chatRoomId: chatRoomId,
        );

  MyChatRoomTileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatRoomId,
  }) : super.internal();

  final String chatRoomId;

  @override
  FutureOr<Member?> runNotifierBuild(
    covariant MyChatRoomTile notifier,
  ) {
    return notifier.build(
      chatRoomId: chatRoomId,
    );
  }

  @override
  Override overrideWith(MyChatRoomTile Function() create) {
    return ProviderOverride(
      origin: this,
      override: MyChatRoomTileProvider._internal(
        () => create()..chatRoomId = chatRoomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatRoomId: chatRoomId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MyChatRoomTile, Member?>
      createElement() {
    return _MyChatRoomTileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyChatRoomTileProvider && other.chatRoomId == chatRoomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatRoomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MyChatRoomTileRef on AutoDisposeAsyncNotifierProviderRef<Member?> {
  /// The parameter `chatRoomId` of this provider.
  String get chatRoomId;
}

class _MyChatRoomTileProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MyChatRoomTile, Member?>
    with MyChatRoomTileRef {
  _MyChatRoomTileProviderElement(super.provider);

  @override
  String get chatRoomId => (origin as MyChatRoomTileProvider).chatRoomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
