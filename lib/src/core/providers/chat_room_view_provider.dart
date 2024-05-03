import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/models/chat_room_info.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';

part 'chat_room_view_provider.g.dart';

@riverpod
class ChatRoomView extends _$ChatRoomView {
  late ChatRoom _roomInfo;

  @override
  Future<ChatRoomInfo> build({required String roomId}) async {
    _roomInfo =
        await ref.read(chatRoomRepositoryProvider).getChatRoomInfo(roomId);
    final Stream<List<Message>> messages =
        ref.read(chatRoomRepositoryProvider).getMessages(_roomInfo.id);

    return ChatRoomInfo(roomInfo: _roomInfo, messageStream: messages);
  }

  // Send message
  Future<void> sendMessage(String message) async {
    ref.read(chatRoomRepositoryProvider).sendMessage(_roomInfo.id, message);
  }

  // Get other user info
  Future<Member> getOtherUserInfo() {
    return ref
        .read(chatRoomRepositoryProvider)
        .getMembers(_roomInfo.id)
        .then((memberList) {
      return memberList.firstWhere(
          (element) => element.uid != FirebaseAuth.instance.currentUser?.uid);
    });
  }
}
