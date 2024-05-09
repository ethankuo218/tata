import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';
import 'package:tata/src/core/repositories/tarot_night_repository.dart';

part 'members_view_provider.g.dart';

@riverpod
class MembersView extends _$MembersView {
  late String _repository;
  late String _roomId;
  late List<Member> _members;

  // Remove Member
  void removeMember(String memberId) async {
    switch (_repository) {
      case 'chat_rooms':
        await ref
            .read(chatRoomRepositoryProvider)
            .removeMember(chatRoomId: _roomId, memberId: memberId)
            .then((_) {
          _members.removeWhere((element) => element.uid == memberId);
          state = AsyncData(_members);
        });
        break;
      case 'tarot_night_rooms':
        await ref
            .read(tarotNightChatRoomRepositoryProvider)
            .removeMember(roomId: _roomId, memberId: memberId)
            .then((_) {
          _members.removeWhere((element) => element.uid == memberId);
          state = AsyncData(_members);
        });
        break;
    }
  }

  @override
  Future<List<Member>> build(
      {required String repository, required String roomId}) async {
    _repository = repository;
    _roomId = roomId;

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
