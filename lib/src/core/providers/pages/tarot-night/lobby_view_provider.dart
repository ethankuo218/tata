import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_lobby_info.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'lobby_view_provider.g.dart';

@Riverpod(keepAlive: true)
class TarotNightLobbyView extends _$TarotNightLobbyView {
  late bool _markedAsNotShowAgain = false;
  late ParticipantStatus _participantStatus = ParticipantStatus.notStarted;
  // ignore: avoid_init_to_null
  late String? _tarotNightRoomId = null;

  @override
  Future<TarotNightLobbyInfo> build() async {
    _participantStatus = await _getParticipantStatus();
    _updateState();

    return TarotNightLobbyInfo(
        markedAsNotShowAgain: _markedAsNotShowAgain,
        participantStatus: _participantStatus,
        tarotNightRoomId: _tarotNightRoomId);
  }

  // Mark as not show again
  void markAsNotShowAgain() {
    _markedAsNotShowAgain = true;
    _updateState();
  }

  // Create Room
  Future<TarotNightRoom> createTarotNightRoom({
    required String title,
    required String description,
    required TarotNightRoomTheme theme,
  }) async {
    return ref
        .read(tarotNightRoomRepositoryProvider)
        .createRoom(
          title: title,
          description: description,
          theme: theme,
        )
        .then((value) {
      _participantStatus = ParticipantStatus.host;
      _tarotNightRoomId = value.id;
      _updateState();
      return value;
    }).catchError((e) => throw e);
  }

  // Update Lobby Info
  Future<void> updateLobbyInfo() async {
    _participantStatus = await _getParticipantStatus();
    _updateState();
  }

  // Check participant status
  Future<ParticipantStatus> _getParticipantStatus() async {
    final List<TarotNightRoom> joinedRooms =
        await ref.read(tarotNightRoomRepositoryProvider).getJoinedRooms();

    final TarotNightRoom? hostRoom =
        await ref.read(tarotNightRoomRepositoryProvider).getHostRoomInfo();

    if (hostRoom != null) {
      _tarotNightRoomId = hostRoom.id;
      return ParticipantStatus.host;
    }

    if (joinedRooms.isNotEmpty) {
      return ParticipantStatus.participant;
    }

    return ParticipantStatus.notStarted;
  }

  // Update State
  void _updateState() {
    state = AsyncData(TarotNightLobbyInfo(
        markedAsNotShowAgain: _markedAsNotShowAgain,
        participantStatus: _participantStatus,
        tarotNightRoomId: _tarotNightRoomId));
  }
}
