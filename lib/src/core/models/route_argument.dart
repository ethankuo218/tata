import 'package:phone_form_field/phone_form_field.dart';

class PhoneVerifyArgument {
  final String verificationId;
  final PhoneNumber phoneNumber;

  PhoneVerifyArgument({
    required this.verificationId,
    required this.phoneNumber,
  });
}
