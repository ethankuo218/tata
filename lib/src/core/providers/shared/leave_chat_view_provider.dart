import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';

part 'leave_chat_view_provider.g.dart';

@riverpod
class LeaveChatView extends _$LeaveChatView {
  late String _roomId;

  @override
  void build({required String roomId}) {
    _roomId = roomId;
  }

  Future<void> leaveChat() {
    return ref.read(chatRoomRepositoryProvider).leaveChatRoom(_roomId);
  }
}
