import 'package:phone_form_field/phone_form_field.dart';
import 'package:tata/src/models/app_user_info.dart';
import 'package:tata/src/models/chat_room.dart';

class ChatRoomArgument {
  final ChatRoom chatRoomInfo;
  final AppUserInfo? otherUserInfo;

  ChatRoomArgument({required this.chatRoomInfo, this.otherUserInfo});
}

class PhoneVerifyArgument {
  final String verificationId;
  final PhoneNumber phoneNumber;

  PhoneVerifyArgument({
    required this.verificationId,
    required this.phoneNumber,
  });
}
