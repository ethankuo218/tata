import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';
import 'package:tata/src/utils/tarot.dart';

part 'chat_room_list_view_provider.g.dart';

@riverpod
class ChatRoomListView extends _$ChatRoomListView {
  bool _hasMore = true;
  final List<ChatRoom> _chatRoomList = [];
  late Map<ChatRoomCategory, List<ChatRoom>> _categoryRoomListMap;

  void setCategoryRoomListMap() {
    for (var room in _chatRoomList) {
      _categoryRoomListMap[ChatRoomCategory.all]?.add(room);
      _categoryRoomListMap[room.category]?.add(room);
    }

    state = AsyncData(_categoryRoomListMap);
  }

  @override
  Future<Map<ChatRoomCategory, List<ChatRoom>>> build() async {
    await fetchFirstList();
    return _categoryRoomListMap;
  }

  // Fetch first page
  Future<void> fetchFirstList() async {
    _chatRoomList.clear();
    _categoryRoomListMap = {
      ChatRoomCategory.all: [],
      ChatRoomCategory.romance: [],
      ChatRoomCategory.work: [],
      ChatRoomCategory.interest: [],
      ChatRoomCategory.sport: [],
      ChatRoomCategory.family: [],
      ChatRoomCategory.friend: [],
      ChatRoomCategory.chitchat: [],
      ChatRoomCategory.school: [],
    };

    final List<ChatRoom> list = await ref
        .read(chatRoomRepositoryProvider)
        .getLobbyChatRoomList(isInitFetch: true);

    _chatRoomList.addAll(list);

    setCategoryRoomListMap();
  }

  // Fetch next page
  Future<void> fetchNextList() async {
    if (!_hasMore) return;

    final List<ChatRoom> list = await ref
        .read(chatRoomRepositoryProvider)
        .getLobbyChatRoomList(isInitFetch: false);

    if (list.isEmpty) {
      _hasMore = false;
      return;
    } else {
      _hasMore = true;
    }

    _chatRoomList.addAll(list);

    setCategoryRoomListMap();
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
