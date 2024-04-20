import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/models/message.dart';
import 'package:tata/src/services/chat.service.dart';

class ChatRoomController {
  late ChatRoom chatRoomInfo;
  late Stream<List<Message>> messagesStream;

  void init({required ChatRoom chatRoom}) {
    chatRoomInfo = chatRoom;
    messagesStream = ChatService().getMessages(chatRoomInfo.id);
  }

  Future<void> sendMessage(String message) {
    return ChatService().sendMessage(chatRoomInfo.id, message);
  }
}
