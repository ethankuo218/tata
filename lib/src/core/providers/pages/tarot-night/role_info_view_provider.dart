import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:tata/src/core/repositories/reference_repository.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'role_info_view_provider.g.dart';

@riverpod
class TarotNightRoleInfoView extends _$TarotNightRoleInfoView {
  late Role _role;

  @override
  Future<Role?> build(String roomId) async {
    _role = await getRole(roomId: roomId);
    state = AsyncData(_role);
    return state.value;
  }

  Future<Role> getRole({required String roomId}) async {
    String roleName = (await ref
            .read(tarotNightRoomRepositoryProvider)
            .getMembers(roomId))
        .firstWhere(
            (element) => element.uid == FirebaseAuth.instance.currentUser!.uid)
        .role;

    return (await ref.read(referenceRepositoryProvider).getRoleList())
        .firstWhere((element) => element.name == roleName);
  }
}
