import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'room_list_view_provider.g.dart';

@riverpod
class TarotNightRoomListView extends _$TarotNightRoomListView {
  late Map<TarotNightRoomTheme, List<TarotNightRoom>> _themeRoomListMap;
  late List<TarotNightRoom> _myRoomList;
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
        await ref.read(tarotNightRoomRepositoryProvider).getJoinedRooms();

    _myRoomList = joinedRooms;

    return ref
        .read(tarotNightRoomRepositoryProvider)
        .getLobbyRoomList()
        .then((list) {
      _themeRoomListMap = {
        // TarotNightRoomTheme.myRoom: joinedRooms,
        TarotNightRoomTheme.all: list
            .map((info) => TarotNightRoom(
                id: info.id,
                theme: info.theme,
                title: info.title,
                description: info.description,
                memberCount: info.memberCount,
                createTime: info.createTime,
                hostId: info.hostId,
                isMember: joinedRooms.any((room) => room.id == info.id)))
            .toList(),
        TarotNightRoomTheme.work: list
            .where((room) => room.theme == TarotNightRoomTheme.work)
            .toList()
            .map((info) => TarotNightRoom(
                id: info.id,
                theme: info.theme,
                title: info.title,
                description: info.description,
                memberCount: info.memberCount,
                createTime: info.createTime,
                hostId: info.hostId,
                isMember: joinedRooms.any((room) => room.id == info.id)))
            .toList(),
        TarotNightRoomTheme.relation: list
            .where((room) => room.theme == TarotNightRoomTheme.relation)
            .toList()
            .map((info) => TarotNightRoom(
                id: info.id,
                theme: info.theme,
                title: info.title,
                description: info.description,
                memberCount: info.memberCount,
                createTime: info.createTime,
                hostId: info.hostId,
                isMember: joinedRooms.any((room) => room.id == info.id)))
            .toList(),
        TarotNightRoomTheme.family: list
            .where((room) => room.theme == TarotNightRoomTheme.family)
            .toList()
            .map((info) => TarotNightRoom(
                id: info.id,
                theme: info.theme,
                title: info.title,
                description: info.description,
                memberCount: info.memberCount,
                createTime: info.createTime,
                hostId: info.hostId,
                isMember: joinedRooms.any((room) => room.id == info.id)))
            .toList(),
        TarotNightRoomTheme.friend: list
            .where((room) => room.theme == TarotNightRoomTheme.friend)
            .toList()
            .map((info) => TarotNightRoom(
                id: info.id,
                theme: info.theme,
                title: info.title,
                description: info.description,
                memberCount: info.memberCount,
                createTime: info.createTime,
                hostId: info.hostId,
                isMember: joinedRooms.any((room) => room.id == info.id)))
            .toList(),
      };
      state = AsyncData(_themeRoomListMap);
    });
  }

  bool isJoinedRoom(String roomId) {
    return _myRoomList.any((element) => element.id == roomId);
  }
}
