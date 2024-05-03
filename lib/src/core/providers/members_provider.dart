import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';
import 'package:tata/src/core/repositories/tarot_night_repository.dart';

part 'members_provider.g.dart';

@riverpod
class Members extends _$Members {
  late String _roomId;
  late List<Member> _members;

  // Remove Member
  Future<void> removeMember(String roomId, String memberId) async {
    await ref
        .read(chatRoomRepositoryProvider)
        .removeMember(chatRoomId: _roomId, memberId: memberId);
    _members.removeWhere((element) => element.uid == memberId);
    state = AsyncData(_members);
  }

  @override
  Future<List<Member>> build(
      {required String repository, required String roomId}) async {
    switch (repository) {
      case 'chat_rooms':
        _members =
            await ref.read(chatRoomRepositoryProvider).getMembers(roomId);
        break;
      case 'tarot_night_rooms':
        _members = await ref
            .read(tarotNightChatRoomRepositoryProvider)
            .getMembers(roomId);
        break;
    }
    state = AsyncData(_members);
    return _members;
  }
}
