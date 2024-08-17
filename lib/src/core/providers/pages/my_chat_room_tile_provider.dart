import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';

part 'my_chat_room_tile_provider.g.dart';

@riverpod
class MyChatRoomTile extends _$MyChatRoomTile {
  @override
  Stream<int> build({required String chatRoomId}) {
    return ref
        .read(chatRoomRepositoryProvider)
        .getUnreadMessageCount(chatRoomId);
  }
}
