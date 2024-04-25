import 'package:tata/src/core/services/chat_service.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/route_argument.dart';

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
