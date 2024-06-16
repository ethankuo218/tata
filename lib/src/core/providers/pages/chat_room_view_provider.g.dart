// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRoomViewHash() => r'3ddfc91a65baed507ec4620302ee50171c13aa28';

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

abstract class _$ChatRoomView
    extends BuildlessAutoDisposeAsyncNotifier<ChatRoomInfo> {
  late final String roomId;

  FutureOr<ChatRoomInfo> build({
    required String roomId,
  });
}

/// See also [ChatRoomView].
@ProviderFor(ChatRoomView)
const chatRoomViewProvider = ChatRoomViewFamily();

/// See also [ChatRoomView].
class ChatRoomViewFamily extends Family<AsyncValue<ChatRoomInfo>> {
  /// See also [ChatRoomView].
  const ChatRoomViewFamily();

  /// See also [ChatRoomView].
  ChatRoomViewProvider call({
    required String roomId,
  }) {
    return ChatRoomViewProvider(
      roomId: roomId,
    );
  }

  @override
  ChatRoomViewProvider getProviderOverride(
    covariant ChatRoomViewProvider provider,
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
  String? get name => r'chatRoomViewProvider';
}

/// See also [ChatRoomView].
class ChatRoomViewProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChatRoomView, ChatRoomInfo> {
  /// See also [ChatRoomView].
  ChatRoomViewProvider({
    required String roomId,
  }) : this._internal(
          () => ChatRoomView()..roomId = roomId,
          from: chatRoomViewProvider,
          name: r'chatRoomViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatRoomViewHash,
          dependencies: ChatRoomViewFamily._dependencies,
          allTransitiveDependencies:
              ChatRoomViewFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  ChatRoomViewProvider._internal(
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
  FutureOr<ChatRoomInfo> runNotifierBuild(
    covariant ChatRoomView notifier,
  ) {
    return notifier.build(
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(ChatRoomView Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatRoomViewProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChatRoomView, ChatRoomInfo>
      createElement() {
    return _ChatRoomViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatRoomViewProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatRoomViewRef on AutoDisposeAsyncNotifierProviderRef<ChatRoomInfo> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _ChatRoomViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatRoomView, ChatRoomInfo>
    with ChatRoomViewRef {
  _ChatRoomViewProviderElement(super.provider);

  @override
  String get roomId => (origin as ChatRoomViewProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
