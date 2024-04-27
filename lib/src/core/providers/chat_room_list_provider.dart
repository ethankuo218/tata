import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';
import 'package:tata/src/ui/tarot.dart';

part 'chat_room_list_provider.g.dart';

@riverpod
class ChatRoomList extends _$ChatRoomList {
  final List<ChatRoom> _chatRoomList = [];
  bool _hasMore = true;

  @override
  Future<List<ChatRoom>> build() async {
    await fetchFirstList();
    return _chatRoomList;
  }

  // Fetch first page
  Future<void> fetchFirstList() async {
    _chatRoomList.clear();

    final List<ChatRoom> list =
        await ref.read(chatRoomRepositoryProvider).getLobbyChatRoomList(true);

    _chatRoomList.addAll(list);

    state = AsyncData(_chatRoomList);
  }

  // Fetch next page
  Future<void> fetchNextList() async {
    if (!_hasMore) return;

    final List<ChatRoom> list =
        await ref.read(chatRoomRepositoryProvider).getLobbyChatRoomList(false);

    if (list.isEmpty) {
      _hasMore = false;
      return;
    }

    _chatRoomList.addAll(list);
    state = AsyncData(_chatRoomList);
  }

  // Create Chat Room
  Future<ChatRoom> createChatRoom({
    required String title,
    required String description,
    required String category,
    required TarotCard backgroundImage,
    required int limit,
  }) async {
    return ref
        .read(chatRoomRepositoryProvider)
        .createChatRoom(
          title: title,
          description: description,
          category: category,
          backgroundImage: backgroundImage,
          limit: limit,
        )
        .then((value) {
      fetchFirstList();
      return value;
    }).catchError((e) => throw e);
  }

  // Join Chat Room
  Future<void> joinChatRoom(ChatRoom chatRoomInfo) async {
    return ref
        .read(chatRoomRepositoryProvider)
        .joinChatRoom(chatRoomInfo)
        .then((value) => fetchFirstList())
        .catchError((e) {
      throw e;
    });
  }
}
