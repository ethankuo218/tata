import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';

part 'my_chat_room_view_provider.g.dart';

@riverpod
class MyChatRoomView extends _$MyChatRoomView {
  @override
  Stream<List<Either<ChatRoom, TarotNightRoom>>> build() {
    return ref.read(chatRoomRepositoryProvider).getUserChatRoomList();
  }

  // Get Other Use Uid
  Future<String> getOtherUserUid(String roomId) {
    return ref
        .read(chatRoomRepositoryProvider)
        .getMembers(roomId)
        .then((memberList) {
      return memberList
          .firstWhere((element) =>
              element.uid != FirebaseAuth.instance.currentUser?.uid)
          .uid;
    });
  }
}
