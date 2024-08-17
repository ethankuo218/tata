// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_info_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tarotNightRoomInfoViewHash() =>
    r'235f720e69ec2c929fbfa5161ed93a9d034d9802';

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

abstract class _$TarotNightRoomInfoView
    extends BuildlessAutoDisposeAsyncNotifier<TarotNightRoom> {
  late final dynamic roomId;

  FutureOr<TarotNightRoom> build(
    dynamic roomId,
  );
}

/// See also [TarotNightRoomInfoView].
@ProviderFor(TarotNightRoomInfoView)
const tarotNightRoomInfoViewProvider = TarotNightRoomInfoViewFamily();

/// See also [TarotNightRoomInfoView].
class TarotNightRoomInfoViewFamily extends Family<AsyncValue<TarotNightRoom>> {
  /// See also [TarotNightRoomInfoView].
  const TarotNightRoomInfoViewFamily();

  /// See also [TarotNightRoomInfoView].
  TarotNightRoomInfoViewProvider call(
    dynamic roomId,
  ) {
    return TarotNightRoomInfoViewProvider(
      roomId,
    );
  }

  @override
  TarotNightRoomInfoViewProvider getProviderOverride(
    covariant TarotNightRoomInfoViewProvider provider,
  ) {
    return call(
      provider.roomId,
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
  String? get name => r'tarotNightRoomInfoViewProvider';
}

/// See also [TarotNightRoomInfoView].
class TarotNightRoomInfoViewProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TarotNightRoomInfoView,
        TarotNightRoom> {
  /// See also [TarotNightRoomInfoView].
  TarotNightRoomInfoViewProvider(
    dynamic roomId,
  ) : this._internal(
          () => TarotNightRoomInfoView()..roomId = roomId,
          from: tarotNightRoomInfoViewProvider,
          name: r'tarotNightRoomInfoViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tarotNightRoomInfoViewHash,
          dependencies: TarotNightRoomInfoViewFamily._dependencies,
          allTransitiveDependencies:
              TarotNightRoomInfoViewFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  TarotNightRoomInfoViewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final dynamic roomId;

  @override
  FutureOr<TarotNightRoom> runNotifierBuild(
    covariant TarotNightRoomInfoView notifier,
  ) {
    return notifier.build(
      roomId,
    );
  }

  @override
  Override overrideWith(TarotNightRoomInfoView Function() create) {
    return ProviderOverride(
      origin: this,
      override: TarotNightRoomInfoViewProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TarotNightRoomInfoView,
      TarotNightRoom> createElement() {
    return _TarotNightRoomInfoViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TarotNightRoomInfoViewProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TarotNightRoomInfoViewRef
    on AutoDisposeAsyncNotifierProviderRef<TarotNightRoom> {
  /// The parameter `roomId` of this provider.
  dynamic get roomId;
}

class _TarotNightRoomInfoViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TarotNightRoomInfoView,
        TarotNightRoom> with TarotNightRoomInfoViewRef {
  _TarotNightRoomInfoViewProviderElement(super.provider);

  @override
  dynamic get roomId => (origin as TarotNightRoomInfoViewProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
