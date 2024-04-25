import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';
import 'package:tata/src/core/repositories/user_repository.dart';

part 'members_provider.g.dart';

@riverpod
class Members extends _$Members {
  late List<AppUserInfo> _members;

  // Remove Member
  Future<void> removeMember(String chatRoomId, String memberId) async {
    await ref
        .read(chatRoomRepositoryProvider)
        .removeMember(chatRoomId: chatRoomId, memberId: memberId);
    _members.removeWhere((element) => element.uid == memberId);
    state = AsyncData(_members);
  }

  @override
  Future<List<AppUserInfo>> build(List<String> uidList) async {
    _members = await ref.read(userRepositoryProvider).getUserInfoList(uidList);
    state = AsyncData(_members);
    return _members;
  }
}
