import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_night_lobby_info.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/repositories/tarot_night_repository.dart';

part 'tarot_night_lobby_provider.g.dart';

@Riverpod(keepAlive: true)
class TarotNightLobby extends _$TarotNightLobby {
  late bool _markedAsNotShowAgain = false;
  late ParticipantStatus _participantStatus = ParticipantStatus.notStarted;

  @override
  Future<TarotNightLobbyInfo> build() async {
    _participantStatus = await _getParticipantStatus();
    _updateState();

    return TarotNightLobbyInfo(
        markedAsNotShowAgain: _markedAsNotShowAgain,
        participantStatus: _participantStatus);
  }

  // Mark as not show again
  void markAsNotShowAgain() {
    _markedAsNotShowAgain = true;
    _updateState();
  }

  // Create Room
  Future<TarotNightRoom> createRoom({
    required String title,
    required String description,
    required TarotNightRoomTheme theme,
  }) async {
    return ref
        .read(tarotNightChatRoomRepositoryProvider)
        .createRoom(
          title: title,
          description: description,
          theme: theme,
        )
        .then((value) {
      _participantStatus = ParticipantStatus.host;
      _updateState();
      return value;
    }).catchError((e) => throw e);
  }

  // Check participant status
  Future<ParticipantStatus> _getParticipantStatus() async {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final List<TarotNightRoom> joinedRooms =
        await ref.read(tarotNightChatRoomRepositoryProvider).getJoinedRooms();

    final List<String> hostList =
        await ref.read(tarotNightChatRoomRepositoryProvider).getHostList();

    if (hostList.contains(currentUserId)) {
      return ParticipantStatus.host;
    }

    if (joinedRooms.isNotEmpty) {
      return ParticipantStatus.member;
    }

    return ParticipantStatus.notStarted;
  }

  // Update State
  void _updateState() {
    state = AsyncData(TarotNightLobbyInfo(
        markedAsNotShowAgain: _markedAsNotShowAgain,
        participantStatus: _participantStatus));
  }
}
