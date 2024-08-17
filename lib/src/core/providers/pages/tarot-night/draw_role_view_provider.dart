import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:tata/src/core/providers/pages/tarot-night/lobby_view_provider.dart';
import 'package:tata/src/core/repositories/reference_repository.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'draw_role_view_provider.g.dart';

@riverpod
class TarotNightDrawRoleView extends _$TarotNightDrawRoleView {
  Role? _role;

  @override
  Future<Role?> build() {
    state = AsyncData(_role);
    return Future(() => null);
  }

  Future<void> drawRole({required String roomId}) async {
    List<String> members =
        (await ref.read(tarotNightRoomRepositoryProvider).getMembers(roomId))
            .map((e) => e.role)
            .toList();
    List<Role> roleList =
        (await ref.read(referenceRepositoryProvider).getRoleList())
            .filter((t) => !members.contains(t.id))
            .toList();

    final number = Random().nextInt(roleList.length);

    _role = roleList[number];

    await ref
        .read(tarotNightRoomRepositoryProvider)
        .joinRoom(roomId: roomId, roleId: roleList[number].id);

    await ref.read(tarotNightLobbyViewProvider.notifier).updateLobbyInfo();

    state = AsyncData(_role);
  }
}
