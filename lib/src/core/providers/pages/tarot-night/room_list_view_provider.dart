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
        TarotNightRoomTheme.all:
            list.map((roomInfo) => checkIsJoinedRoom(roomInfo)).toList(),
        TarotNightRoomTheme.work: list
            .where((room) => room.theme == TarotNightRoomTheme.work)
            .toList()
            .map(
              (roomInfo) => checkIsJoinedRoom(roomInfo),
            )
            .toList(),
        TarotNightRoomTheme.relation: list
            .where((room) => room.theme == TarotNightRoomTheme.relation)
            .toList()
            .map((roomInfo) => checkIsJoinedRoom(roomInfo))
            .toList(),
        TarotNightRoomTheme.family: list
            .where((room) => room.theme == TarotNightRoomTheme.family)
            .toList()
            .map((roomInfo) => checkIsJoinedRoom(roomInfo))
            .toList(),
        TarotNightRoomTheme.friend: list
            .where((room) => room.theme == TarotNightRoomTheme.friend)
            .toList()
            .map((roomInfo) => checkIsJoinedRoom(roomInfo))
            .toList(),
      };
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
