import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/models/tarot_night_room_info.dart';
import 'package:tata/src/core/repositories/tarot_night_repository.dart';

part 'tarot_night_room_view_provider.g.dart';

@riverpod
class TarotNightRoomView extends _$TarotNightRoomView {
  late TarotNightRoom _roomInfo;

  @override
  Future<TarotNightRoomInfo> build({required String roomId}) async {
    _roomInfo = await ref
        .read(tarotNightChatRoomRepositoryProvider)
        .getRoomInfo(roomId);
    final Stream<List<Message>> messages = ref
        .read(tarotNightChatRoomRepositoryProvider)
        .getMessages(_roomInfo.id);

    return TarotNightRoomInfo(roomInfo: _roomInfo, messageStream: messages);
  }

  // Send message
  Future<void> sendMessage(String message) async {
    ref
        .read(tarotNightChatRoomRepositoryProvider)
        .sendMessage(_roomInfo.id, message);
  }
}
