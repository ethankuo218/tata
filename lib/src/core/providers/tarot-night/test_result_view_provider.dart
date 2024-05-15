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
  TarotNightRoom? _roomInfo;
  TarotCard? _card;

  @override
  Future<TarotNightRoom> build({required String roomId}) async {
    _roomInfo =
        await ref.read(tarotNightRoomRepositoryProvider).getRoomInfo(roomId);
    _card = await ref
        .read(referenceRepositoryProvider)
        .getTarotCard(_roomInfo!.card!);

    state = AsyncData(_roomInfo!);
    return Future(() => _roomInfo!);
  }

  Future<Role> getRole() async {
    final String roleId = (await ref
            .read(tarotNightRoomRepositoryProvider)
            .getMembers(_roomInfo!.id))
        .firstWhere(
            (element) => element.uid == FirebaseAuth.instance.currentUser!.uid)
        .role;

    return ref.read(referenceRepositoryProvider).getRole(roleId);
  }

  Future<String> getQuest() async {
    List<Member> members = await ref
        .read(tarotNightRoomRepositoryProvider)
        .getMembers(_roomInfo!.id);

    return members
        .firstWhere(
            (element) => element.uid == FirebaseAuth.instance.currentUser!.uid)
        .quest;
  }

  Future<void> submitTaskAnswer(String answer) {
    // send the message to chat room
    return ref
        .read(tarotNightRoomRepositoryProvider)
        .updateAnswer(_roomInfo!.id, answer);
  }

  TarotCard getCard() {
    return _card!;
  }
}
