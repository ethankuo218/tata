import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/tarot_night_repository.dart';

part 'tarot_night_room_list_view_provider.g.dart';

@riverpod
class TarotNightRoomListView extends _$TarotNightRoomListView {
  late Map<TarotNightRoomTheme, List<TarotNightRoom>> themeRoomListMap;

  @override
  Future<Map<TarotNightRoomTheme, List<TarotNightRoom>>> build() async {
    await _updateThemeRoomListMap();
    return themeRoomListMap;
  }

  Future<void> _updateThemeRoomListMap() {
    return ref
        .read(tarotNightChatRoomRepositoryProvider)
        .getLobbyRoomList()
        .then((list) {
      themeRoomListMap = {
        TarotNightRoomTheme.myRoom: list
            .where(
                (room) => room.hostId == FirebaseAuth.instance.currentUser?.uid)
            .toList(),
        TarotNightRoomTheme.all: list,
        TarotNightRoomTheme.work: list
            .where((room) => room.theme == TarotNightRoomTheme.work)
            .toList(),
        TarotNightRoomTheme.relation: list
            .where((room) => room.theme == TarotNightRoomTheme.relation)
            .toList(),
        TarotNightRoomTheme.family: list
            .where((room) => room.theme == TarotNightRoomTheme.family)
            .toList(),
        TarotNightRoomTheme.friend: list
            .where((room) => room.theme == TarotNightRoomTheme.friend)
            .toList(),
      };
      state = AsyncData(themeRoomListMap);
    });
  }
}
