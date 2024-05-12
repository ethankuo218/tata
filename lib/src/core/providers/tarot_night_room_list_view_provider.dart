import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'tarot_night_room_list_view_provider.g.dart';

@riverpod
class TarotNightRoomListView extends _$TarotNightRoomListView {
  late Map<TarotNightRoomTheme, List<TarotNightRoom>> _themeRoomListMap;

  @override
  Future<Map<TarotNightRoomTheme, List<TarotNightRoom>>> build() async {
    await _updateThemeRoomListMap();
    return _themeRoomListMap;
  }

  Future<void> reload() {
    return _updateThemeRoomListMap();
  }

  Future<void> _updateThemeRoomListMap() async {
    List<TarotNightRoom> joinedRooms =
        await ref.read(tarotNightChatRoomRepositoryProvider).getJoinedRooms();

    return ref
        .read(tarotNightChatRoomRepositoryProvider)
        .getLobbyRoomList()
        .then((list) {
      _themeRoomListMap = {
        TarotNightRoomTheme.myRoom: joinedRooms,
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
      state = AsyncData(_themeRoomListMap);
    });
  }

  bool isJoinedRoom(String roomId) {
    return _themeRoomListMap[TarotNightRoomTheme.myRoom]!
        .any((element) => element.id == roomId);
  }
}
