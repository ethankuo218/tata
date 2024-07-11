import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';
import 'package:tata/src/utils/tarot.dart';

part 'chat_room_list_view_provider.g.dart';

@riverpod
class ChatRoomListView extends _$ChatRoomListView {
  final List<ChatRoom> _chatRoomList = [];
  bool _hasMore = true;
  String _category = 'all';

  @override
  Future<List<ChatRoom>> build() async {
    await fetchFirstList();
    return _chatRoomList;
  }

  // Fetch first page
  Future<void> fetchFirstList() async {
    _chatRoomList.clear();

    final List<ChatRoom> list = await ref
        .read(chatRoomRepositoryProvider)
        .getLobbyChatRoomList(isInitFetch: true, category: _category);

    _chatRoomList.addAll(list);

    state = AsyncData(_chatRoomList);
  }

  // Fetch next page
  Future<void> fetchNextList() async {
    if (!_hasMore) return;

    final List<ChatRoom> list = await ref
        .read(chatRoomRepositoryProvider)
        .getLobbyChatRoomList(isInitFetch: false, category: _category);

    if (list.isEmpty) {
      _hasMore = false;
      return;
    }

    _chatRoomList.addAll(list);
    state = AsyncData(_chatRoomList);
  }

  // Set Category
  Future<void> setCategory(ChatRoomCategory category) async {
    _category = category.value;
    await fetchFirstList();
  }

  // Create Chat Room
  Future<String> createChatRoom({
    required String title,
    required String description,
    required ChatRoomCategory category,
    required TarotCardKey backgroundImage,
    required int limit,
  }) async {
    return ref
        .read(chatRoomRepositoryProvider)
        .createChatRoom(
          title: title,
          description: description,
          category: category,
          limit: limit,
        )
        .then((value) {
      fetchFirstList();
      return value;
    }).catchError((e) => throw e);
  }

  // Join Chat Room
  Future<void> joinChatRoom(String chatRoomId) async {
    return ref
        .read(chatRoomRepositoryProvider)
        .joinChatRoom(chatRoomId)
        .then((value) => fetchFirstList())
        .catchError((e) {
      throw e;
    });
  }
}
