class TarotNightLobbyInfo {
  final bool markedAsNotShowAgain;
  final ParticipantStatus participantStatus;
  final String? tarotNightRoomId;

  TarotNightLobbyInfo(
      {required this.markedAsNotShowAgain,
      required this.participantStatus,
      this.tarotNightRoomId});
}

enum ParticipantStatus {
  host('host'),
  participant('participant'),
  notStarted('not_started'),
  ;

  const ParticipantStatus(this.value);

  factory ParticipantStatus.toEnum(String value) {
    var filter = values.where((element) => element.value == value);

    if (filter.isEmpty) {
      throw Exception('Invalid status name');
    }

    return filter.first;
  }

  final String value;
}
