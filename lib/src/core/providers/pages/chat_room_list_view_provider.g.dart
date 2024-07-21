// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_list_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRoomListViewHash() => r'e30646b386adb5880835aa809d8141848c9a47ac';

/// See also [ChatRoomListView].
@ProviderFor(ChatRoomListView)
final chatRoomListViewProvider = AutoDisposeAsyncNotifierProvider<
    ChatRoomListView, Map<ChatRoomCategory, List<ChatRoom>>>.internal(
  ChatRoomListView.new,
  name: r'chatRoomListViewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRoomListViewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatRoomListView
    = AutoDisposeAsyncNotifier<Map<ChatRoomCategory, List<ChatRoom>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
