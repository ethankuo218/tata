import 'package:tata/src/models/message.dart';
import 'package:tata/src/models/route_argument.dart';
import 'package:tata/src/services/chat.service.dart';

class ChatRoomController {
  ChatRoomController(this._chatRoomArgument);
  final ChatRoomArgument _chatRoomArgument;

  late Stream<List<Message>> messagesStream =
      ChatService().getMessages(_chatRoomArgument.chatRoomInfo.id);

  Future<void> sendMessage(String message) {
    return ChatService()
        .sendMessage(_chatRoomArgument.chatRoomInfo.id, message);
  }
}
