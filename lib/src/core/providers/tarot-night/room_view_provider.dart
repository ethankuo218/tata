import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_message.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/models/tarot_night_room_info.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'room_view_provider.g.dart';

@riverpod
class TarotNightRoomView extends _$TarotNightRoomView {
  late TarotNightRoom _roomInfo;

  @override
  Future<TarotNightRoomInfo> build({required String roomId}) async {
    _roomInfo =
        await ref.read(tarotNightRoomRepositoryProvider).getRoomInfo(roomId);
    final Stream<List<TarotNightMessage>> messages =
        ref.read(tarotNightRoomRepositoryProvider).getMessages(_roomInfo.id);

    return TarotNightRoomInfo(roomInfo: _roomInfo, messageStream: messages);
  }

  // Send message
  Future<void> sendMessage(String message) async {
    ref
        .read(tarotNightRoomRepositoryProvider)
        .sendMessage(chatRoomId: _roomInfo.id, message: message);
  }
}
