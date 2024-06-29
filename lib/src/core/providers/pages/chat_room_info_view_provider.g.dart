// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_info_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRoomInfoViewHash() => r'cb99ddabdc58386d3241a2feb78b31d5dd3f8043';

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

abstract class _$ChatRoomInfoView
    extends BuildlessAutoDisposeAsyncNotifier<ChatRoom> {
  late final String roomId;

  FutureOr<ChatRoom> build({
    required String roomId,
  });
}

/// See also [ChatRoomInfoView].
@ProviderFor(ChatRoomInfoView)
const chatRoomInfoViewProvider = ChatRoomInfoViewFamily();

/// See also [ChatRoomInfoView].
class ChatRoomInfoViewFamily extends Family<AsyncValue<ChatRoom>> {
  /// See also [ChatRoomInfoView].
  const ChatRoomInfoViewFamily();

  /// See also [ChatRoomInfoView].
  ChatRoomInfoViewProvider call({
    required String roomId,
  }) {
    return ChatRoomInfoViewProvider(
      roomId: roomId,
    );
  }

  @override
  ChatRoomInfoViewProvider getProviderOverride(
    covariant ChatRoomInfoViewProvider provider,
  ) {
    return call(
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
  String? get name => r'chatRoomInfoViewProvider';
}

/// See also [ChatRoomInfoView].
class ChatRoomInfoViewProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChatRoomInfoView, ChatRoom> {
  /// See also [ChatRoomInfoView].
  ChatRoomInfoViewProvider({
    required String roomId,
  }) : this._internal(
          () => ChatRoomInfoView()..roomId = roomId,
          from: chatRoomInfoViewProvider,
          name: r'chatRoomInfoViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatRoomInfoViewHash,
          dependencies: ChatRoomInfoViewFamily._dependencies,
          allTransitiveDependencies:
              ChatRoomInfoViewFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  ChatRoomInfoViewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  FutureOr<ChatRoom> runNotifierBuild(
    covariant ChatRoomInfoView notifier,
  ) {
    return notifier.build(
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(ChatRoomInfoView Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatRoomInfoViewProvider._internal(
        () => create()..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatRoomInfoView, ChatRoom>
      createElement() {
    return _ChatRoomInfoViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatRoomInfoViewProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatRoomInfoViewRef on AutoDisposeAsyncNotifierProviderRef<ChatRoom> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _ChatRoomInfoViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatRoomInfoView, ChatRoom>
    with ChatRoomInfoViewRef {
  _ChatRoomInfoViewProviderElement(super.provider);

  @override
  String get roomId => (origin as ChatRoomInfoViewProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
