import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';

class TarotNightRoomInfo {
  final TarotNightRoom roomInfo;
  final Stream<List<Message>> messageStream;

  TarotNightRoomInfo({
    required this.roomInfo,
    required this.messageStream,
  });
}
