// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tarotNightRoomViewHash() =>
    r'f77616940eb885453a4941af05724ecb24199416';

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

abstract class _$TarotNightRoomView
    extends BuildlessAutoDisposeAsyncNotifier<TarotNightRoomInfo> {
  late final String roomId;

  FutureOr<TarotNightRoomInfo> build({
    required String roomId,
  });
}

/// See also [TarotNightRoomView].
@ProviderFor(TarotNightRoomView)
const tarotNightRoomViewProvider = TarotNightRoomViewFamily();

/// See also [TarotNightRoomView].
class TarotNightRoomViewFamily extends Family<AsyncValue<TarotNightRoomInfo>> {
  /// See also [TarotNightRoomView].
  const TarotNightRoomViewFamily();

  /// See also [TarotNightRoomView].
  TarotNightRoomViewProvider call({
    required String roomId,
  }) {
    return TarotNightRoomViewProvider(
      roomId: roomId,
    );
  }

  @override
  TarotNightRoomViewProvider getProviderOverride(
    covariant TarotNightRoomViewProvider provider,
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
  String? get name => r'tarotNightRoomViewProvider';
}

/// See also [TarotNightRoomView].
class TarotNightRoomViewProvider extends AutoDisposeAsyncNotifierProviderImpl<
    TarotNightRoomView, TarotNightRoomInfo> {
  /// See also [TarotNightRoomView].
  TarotNightRoomViewProvider({
    required String roomId,
  }) : this._internal(
          () => TarotNightRoomView()..roomId = roomId,
          from: tarotNightRoomViewProvider,
          name: r'tarotNightRoomViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tarotNightRoomViewHash,
          dependencies: TarotNightRoomViewFamily._dependencies,
          allTransitiveDependencies:
              TarotNightRoomViewFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  TarotNightRoomViewProvider._internal(
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
  FutureOr<TarotNightRoomInfo> runNotifierBuild(
    covariant TarotNightRoomView notifier,
  ) {
    return notifier.build(
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(TarotNightRoomView Function() create) {
    return ProviderOverride(
      origin: this,
      override: TarotNightRoomViewProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TarotNightRoomView,
      TarotNightRoomInfo> createElement() {
    return _TarotNightRoomViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TarotNightRoomViewProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TarotNightRoomViewRef
    on AutoDisposeAsyncNotifierProviderRef<TarotNightRoomInfo> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _TarotNightRoomViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TarotNightRoomView,
        TarotNightRoomInfo> with TarotNightRoomViewRef {
  _TarotNightRoomViewProviderElement(super.provider);

  @override
  String get roomId => (origin as TarotNightRoomViewProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
