import 'package:phone_form_field/phone_form_field.dart';
import 'package:tata/src/core/models/chat_room.dart';

class ChatRoomArgument {
  final ChatRoom chatRoomInfo;
  final String? otherUserUid;

  ChatRoomArgument({required this.chatRoomInfo, this.otherUserUid});
}

class PhoneVerifyArgument {
  final String verificationId;
  final PhoneNumber phoneNumber;

  PhoneVerifyArgument({
    required this.verificationId,
    required this.phoneNumber,
  });
}
