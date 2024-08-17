import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/models/message.dart';

class ChatRoomInfo {
  final ChatRoom roomInfo;
  final Stream<List<Message>> messageStream;

  ChatRoomInfo({
    required this.roomInfo,
    required this.messageStream,
  });
}
