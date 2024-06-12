import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/core/models/tarot_night_message.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/models/tarot_night_room_info.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';
import 'package:tata/src/core/repositories/user_repository.dart';

part 'room_view_provider.g.dart';

@riverpod
class TarotNightRoomView extends _$TarotNightRoomView {
  late TarotNightRoom _roomInfo;
  late AppUserInfo _userInfo;

  @override
  Future<TarotNightRoomInfo> build({required String roomId}) async {
    _roomInfo =
        await ref.read(tarotNightRoomRepositoryProvider).getRoomInfo(roomId);

    _userInfo = await ref
        .read(userRepositoryProvider)
        .getUserInfo(FirebaseAuth.instance.currentUser!.uid);

    final Stream<List<TarotNightMessage>> messages =
        ref.read(tarotNightRoomRepositoryProvider).getMessages(_roomInfo.id);

    return TarotNightRoomInfo(roomInfo: _roomInfo, messageStream: messages);
  }

  // Send message
  Future<void> sendMessage(String message) async {
    ref.read(tarotNightRoomRepositoryProvider).sendMessage(
        userInfo: _userInfo, chatRoomId: _roomInfo.id, message: message);
  }
}
