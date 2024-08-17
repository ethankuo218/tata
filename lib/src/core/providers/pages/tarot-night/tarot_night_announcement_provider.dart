import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'tarot_night_announcement_provider.g.dart';

@Riverpod(keepAlive: true)
class TarotNightAnnouncement extends _$TarotNightAnnouncement {
  late TarotNightRoom? _roomInfo;

  @override
  Future<TarotNightRoom?> build() async {
    return _roomInfo;
  }

  Future<void> loadTarotNightRoomInfo(String roomId) async {
    _roomInfo =
        await ref.read(tarotNightRoomRepositoryProvider).getRoomInfo(roomId);
    state = AsyncData(_roomInfo);
  }
}
