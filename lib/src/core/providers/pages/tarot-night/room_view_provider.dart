import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/models/tarot_night_message.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/models/tarot_night_room_info.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'room_view_provider.g.dart';

@riverpod
class TarotNightRoomView extends _$TarotNightRoomView {
  late TarotNightRoom _roomInfo;
  late MemberInfo _memberInfo;

  @override
  Future<TarotNightRoomInfo> build({required String roomId}) async {
    _roomInfo =
        await ref.read(tarotNightRoomRepositoryProvider).getRoomInfo(roomId);

    _memberInfo = await ref
        .read(tarotNightRoomRepositoryProvider)
        .getMemberInfo(roomId, FirebaseAuth.instance.currentUser!.uid);

    final Stream<List<TarotNightMessage>> messages =
        ref.read(tarotNightRoomRepositoryProvider).getMessages(_roomInfo.id);

    markAsRead();

    return TarotNightRoomInfo(roomInfo: _roomInfo, messageStream: messages);
  }

  // Send message
  Future<void> sendMessage(String message) async {
    ref.read(tarotNightRoomRepositoryProvider).sendMessage(
        memberInfo: _memberInfo, chatRoomId: _roomInfo.id, content: message);
  }

  // Mark as read
  Future<void> markAsRead() async {
    ref
        .read(tarotNightRoomRepositoryProvider)
        .markAsRead(roomId: _roomInfo.id, memberId: _memberInfo.uid);
  }
}
