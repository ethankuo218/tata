import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'room_info_view_provider.g.dart';

@riverpod
class TarotNightRoomInfoView extends _$TarotNightRoomInfoView {
  late String _roomId;

  @override
  Future<TarotNightRoom> build(roomId) async {
    _roomId = roomId;

    return await ref
        .read(tarotNightRoomRepositoryProvider)
        .getRoomInfo(_roomId);
  }

  Future<void> editTarotNightRoomInfo(
      {required String theme,
      required String title,
      required String description}) async {
    return ref.read(tarotNightRoomRepositoryProvider).editRoomInfo(_roomId,
        theme: theme, title: title, description: description);
  }
}
