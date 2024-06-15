import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';

part 'my_chat_room_tile_provider.g.dart';

@riverpod
class MyChatRoomTile extends _$MyChatRoomTile {
  @override
  Future<MemberInfo?> build({required String chatRoomId}) async {
    List<MemberInfo> memberList =
        await ref.read(chatRoomRepositoryProvider).getMembers(chatRoomId);

    return memberList.length == 1
        ? null
        : memberList.firstWhere(
            (member) => member.uid != FirebaseAuth.instance.currentUser!.uid);
  }
}
