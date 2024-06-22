// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_chat_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$leaveChatViewHash() => r'52931d42984f26882d55655a23ba02eb5e6c024c';

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

abstract class _$LeaveChatView extends BuildlessAutoDisposeNotifier<void> {
  late final String roomId;

  void build({
    required String roomId,
  });
}

/// See also [LeaveChatView].
@ProviderFor(LeaveChatView)
const leaveChatViewProvider = LeaveChatViewFamily();

/// See also [LeaveChatView].
class LeaveChatViewFamily extends Family<void> {
  /// See also [LeaveChatView].
  const LeaveChatViewFamily();

  /// See also [LeaveChatView].
  LeaveChatViewProvider call({
    required String roomId,
  }) {
    return LeaveChatViewProvider(
      roomId: roomId,
    );
  }

  @override
  LeaveChatViewProvider getProviderOverride(
    covariant LeaveChatViewProvider provider,
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
  String? get name => r'leaveChatViewProvider';
}

/// See also [LeaveChatView].
class LeaveChatViewProvider
    extends AutoDisposeNotifierProviderImpl<LeaveChatView, void> {
  /// See also [LeaveChatView].
  LeaveChatViewProvider({
    required String roomId,
  }) : this._internal(
          () => LeaveChatView()..roomId = roomId,
          from: leaveChatViewProvider,
          name: r'leaveChatViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$leaveChatViewHash,
          dependencies: LeaveChatViewFamily._dependencies,
          allTransitiveDependencies:
              LeaveChatViewFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  LeaveChatViewProvider._internal(
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
  void runNotifierBuild(
    covariant LeaveChatView notifier,
  ) {
    return notifier.build(
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(LeaveChatView Function() create) {
    return ProviderOverride(
      origin: this,
      override: LeaveChatViewProvider._internal(
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
  AutoDisposeNotifierProviderElement<LeaveChatView, void> createElement() {
    return _LeaveChatViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveChatViewProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LeaveChatViewRef on AutoDisposeNotifierProviderRef<void> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _LeaveChatViewProviderElement
    extends AutoDisposeNotifierProviderElement<LeaveChatView, void>
    with LeaveChatViewRef {
  _LeaveChatViewProviderElement(super.provider);

  @override
  String get roomId => (origin as LeaveChatViewProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
