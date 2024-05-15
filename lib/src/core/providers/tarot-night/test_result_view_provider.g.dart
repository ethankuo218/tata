// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tarotNightTestResultViewHash() =>
    r'84df1ba18989ecf759cf92d7d8cd3bb74deefde6';

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

abstract class _$TarotNightTestResultView
    extends BuildlessAutoDisposeAsyncNotifier<TarotNightRoom> {
  late final String roomId;

  FutureOr<TarotNightRoom> build({
    required String roomId,
  });
}

/// See also [TarotNightTestResultView].
@ProviderFor(TarotNightTestResultView)
const tarotNightTestResultViewProvider = TarotNightTestResultViewFamily();

/// See also [TarotNightTestResultView].
class TarotNightTestResultViewFamily
    extends Family<AsyncValue<TarotNightRoom>> {
  /// See also [TarotNightTestResultView].
  const TarotNightTestResultViewFamily();

  /// See also [TarotNightTestResultView].
  TarotNightTestResultViewProvider call({
    required String roomId,
  }) {
    return TarotNightTestResultViewProvider(
      roomId: roomId,
    );
  }

  @override
  TarotNightTestResultViewProvider getProviderOverride(
    covariant TarotNightTestResultViewProvider provider,
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
  String? get name => r'tarotNightTestResultViewProvider';
}

/// See also [TarotNightTestResultView].
class TarotNightTestResultViewProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TarotNightTestResultView,
        TarotNightRoom> {
  /// See also [TarotNightTestResultView].
  TarotNightTestResultViewProvider({
    required String roomId,
  }) : this._internal(
          () => TarotNightTestResultView()..roomId = roomId,
          from: tarotNightTestResultViewProvider,
          name: r'tarotNightTestResultViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tarotNightTestResultViewHash,
          dependencies: TarotNightTestResultViewFamily._dependencies,
          allTransitiveDependencies:
              TarotNightTestResultViewFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  TarotNightTestResultViewProvider._internal(
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
  FutureOr<TarotNightRoom> runNotifierBuild(
    covariant TarotNightTestResultView notifier,
  ) {
    return notifier.build(
      roomId: roomId,
    );
  }

  @override
  Override overrideWith(TarotNightTestResultView Function() create) {
    return ProviderOverride(
      origin: this,
      override: TarotNightTestResultViewProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TarotNightTestResultView,
      TarotNightRoom> createElement() {
    return _TarotNightTestResultViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TarotNightTestResultViewProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TarotNightTestResultViewRef
    on AutoDisposeAsyncNotifierProviderRef<TarotNightRoom> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _TarotNightTestResultViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TarotNightTestResultView,
        TarotNightRoom> with TarotNightTestResultViewRef {
  _TarotNightTestResultViewProviderElement(super.provider);

  @override
  String get roomId => (origin as TarotNightTestResultViewProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
