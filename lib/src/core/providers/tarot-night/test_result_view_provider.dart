import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:tata/src/core/models/tarot_card.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/reference_repository.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'test_result_view_provider.g.dart';

@riverpod
class TarotNightTestResultView extends _$TarotNightTestResultView {
  late TarotNightRoom _roomInfo;
  late TarotCard _card;
  late MemberInfo _memberInfo;

  @override
  Future<TarotNightRoom> build({required String roomId}) async {
    _roomInfo =
        await ref.read(tarotNightRoomRepositoryProvider).getRoomInfo(roomId);

    _card = await ref
        .read(referenceRepositoryProvider)
        .getTarotCard(_roomInfo.card!);

    _memberInfo = await ref
        .read(tarotNightRoomRepositoryProvider)
        .getMemberInfo(roomId, FirebaseAuth.instance.currentUser!.uid);

    state = AsyncData(_roomInfo);
    return Future(() => _roomInfo);
  }

  Future<Role> getRole() async {
    final String roleId = (await ref
            .read(tarotNightRoomRepositoryProvider)
            .getMembers(_roomInfo.id))
        .firstWhere(
            (element) => element.uid == FirebaseAuth.instance.currentUser!.uid)
        .role;

    return ref.read(referenceRepositoryProvider).getRole(roleId);
  }

  Future<String> getQuest() async {
    List<MemberInfo> members = await ref
        .read(tarotNightRoomRepositoryProvider)
        .getMembers(_roomInfo.id);

    return members
        .firstWhere(
            (element) => element.uid == FirebaseAuth.instance.currentUser!.uid)
        .quest;
  }

  Future<void> submitTaskAnswer(String answer) {
    return ref.read(tarotNightRoomRepositoryProvider).updateAnswer(
        memberInfo: _memberInfo, roomId: _roomInfo.id, answer: answer);
  }

  TarotCard getCard() {
    return _card;
  }
}
