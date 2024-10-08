import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'room_list_view_provider.g.dart';

@riverpod
class TarotNightRoomListView extends _$TarotNightRoomListView {
  late Map<TarotNightRoomTheme, List<TarotNightRoom>> _themeRoomListMap;
  late List<TarotNightRoom> _joinedRooms;

  @override
  Future<Map<TarotNightRoomTheme, List<TarotNightRoom>>> build() async {
    await _updateThemeRoomListMap();
    return _themeRoomListMap;
  }

  Future<void> reload() {
    return _updateThemeRoomListMap();
  }

  Future<void> _updateThemeRoomListMap() async {
    _joinedRooms =
        await ref.read(tarotNightRoomRepositoryProvider).getJoinedRooms();

    return ref
        .read(tarotNightRoomRepositoryProvider)
        .getLobbyRoomList()
        .then((list) {
      _themeRoomListMap = {
        TarotNightRoomTheme.all: list,
        TarotNightRoomTheme.work: [],
        TarotNightRoomTheme.relation: [],
        TarotNightRoomTheme.family: [],
        TarotNightRoomTheme.friend: [],
      };

      for (var room in list) {
        _themeRoomListMap[room.theme]?.add(checkIsJoinedRoom(room));
      }

      state = AsyncData(_themeRoomListMap);
    });
  }

  TarotNightRoom checkIsJoinedRoom(TarotNightRoom roomInfo) {
    bool isJoined = _joinedRooms.any((element) => element.id == roomInfo.id);

    return isJoined
        ? _joinedRooms.firstWhere((element) => element.id == roomInfo.id)
        : roomInfo;
  }
}
