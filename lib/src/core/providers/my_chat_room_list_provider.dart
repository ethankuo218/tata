import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';

part 'my_chat_room_list_provider.g.dart';

@riverpod
Stream<List<ChatRoom>> myChatRoomList(MyChatRoomListRef ref) async* {
  await for (final chatRoomList
      in ref.read(chatRoomRepositoryProvider).getUserChatRoomList()) {
    yield chatRoomList;
  }
}
