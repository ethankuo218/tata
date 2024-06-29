import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';

part 'chat_room_info_view_provider.g.dart';

@riverpod
class ChatRoomInfoView extends _$ChatRoomInfoView {
  late String _roomId;
  late ChatRoom _roomInfo;

  @override
  Future<ChatRoom> build({required String roomId}) async {
    _roomId = roomId;
    await loadChatRoomInfo();
    return _roomInfo;
  }

  Future<void> loadChatRoomInfo() async {
    _roomInfo =
        await ref.read(chatRoomRepositoryProvider).getChatRoomInfo(_roomId);

    state = AsyncData(_roomInfo);
  }

  void editChatRoomInfo({
    required String title,
    required String description,
    required String category,
    required int limit,
  }) {
    ref
        .read(chatRoomRepositoryProvider)
        .editChatRoomInfo(
          roomId: _roomId,
          title: title,
          description: description,
          category: category,
          limit: limit,
        )
        .then((value) => {loadChatRoomInfo()});
  }
}
