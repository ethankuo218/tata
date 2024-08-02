// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_info_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tarotNightRoleInfoViewHash() =>
    r'c4f396086885dd1d0463d796418f097b6c7ed5aa';

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

abstract class _$TarotNightRoleInfoView
    extends BuildlessAutoDisposeAsyncNotifier<Role?> {
  late final String roomId;

  FutureOr<Role?> build(
    String roomId,
  );
}

/// See also [TarotNightRoleInfoView].
@ProviderFor(TarotNightRoleInfoView)
const tarotNightRoleInfoViewProvider = TarotNightRoleInfoViewFamily();

/// See also [TarotNightRoleInfoView].
class TarotNightRoleInfoViewFamily extends Family<AsyncValue<Role?>> {
  /// See also [TarotNightRoleInfoView].
  const TarotNightRoleInfoViewFamily();

  /// See also [TarotNightRoleInfoView].
  TarotNightRoleInfoViewProvider call(
    String roomId,
  ) {
    return TarotNightRoleInfoViewProvider(
      roomId,
    );
  }

  @override
  TarotNightRoleInfoViewProvider getProviderOverride(
    covariant TarotNightRoleInfoViewProvider provider,
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
  String? get name => r'tarotNightRoleInfoViewProvider';
}

/// See also [TarotNightRoleInfoView].
class TarotNightRoleInfoViewProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TarotNightRoleInfoView,
        Role?> {
  /// See also [TarotNightRoleInfoView].
  TarotNightRoleInfoViewProvider(
    String roomId,
  ) : this._internal(
          () => TarotNightRoleInfoView()..roomId = roomId,
          from: tarotNightRoleInfoViewProvider,
          name: r'tarotNightRoleInfoViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tarotNightRoleInfoViewHash,
          dependencies: TarotNightRoleInfoViewFamily._dependencies,
          allTransitiveDependencies:
              TarotNightRoleInfoViewFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  TarotNightRoleInfoViewProvider._internal(
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
  FutureOr<Role?> runNotifierBuild(
    covariant TarotNightRoleInfoView notifier,
  ) {
    return notifier.build(
      roomId,
    );
  }

  @override
  Override overrideWith(TarotNightRoleInfoView Function() create) {
    return ProviderOverride(
      origin: this,
      override: TarotNightRoleInfoViewProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TarotNightRoleInfoView, Role?>
      createElement() {
    return _TarotNightRoleInfoViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TarotNightRoleInfoViewProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TarotNightRoleInfoViewRef on AutoDisposeAsyncNotifierProviderRef<Role?> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _TarotNightRoleInfoViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TarotNightRoleInfoView,
        Role?> with TarotNightRoleInfoViewRef {
  _TarotNightRoleInfoViewProviderElement(super.provider);

  @override
  String get roomId => (origin as TarotNightRoleInfoViewProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
