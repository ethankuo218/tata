class TarotNightLobbyInfo {
  final bool markedAsNotShowAgain;
  final ParticipantStatus participantStatus;

  TarotNightLobbyInfo({
    required this.markedAsNotShowAgain,
    required this.participantStatus,
  });
}

enum ParticipantStatus {
  host('host'),
  member('member'),
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
