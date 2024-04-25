import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pinput/pinput.dart';
import 'package:tata/src/core/providers/auth_provider.dart';
import 'package:tata/src/core/models/route_argument.dart';

class PhoneVerifyOtpView extends ConsumerStatefulWidget {
  const PhoneVerifyOtpView({super.key, required this.args});

  static const String routeName = '/phone-verify/otp';

  final PhoneVerifyArgument args;

  @override
  ConsumerState<PhoneVerifyOtpView> createState() => _PhoneVerifyOtpViewState();
}

class _PhoneVerifyOtpViewState extends ConsumerState<PhoneVerifyOtpView> {
  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isSendOtpCoolDown = false;

  late Timer timer = Timer.periodic(const Duration(), (_) {});
  Duration duration = const Duration();

  String timerText = '05:00';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    pinController.dispose();
    focusNode.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final String verificationId = widget.args.verificationId;
    final PhoneNumber phoneNumber = widget.args.phoneNumber;

    final displayPhoneNumber =
        '+${phoneNumber.countryCode} ${'*' * (phoneNumber.nsn.length - 2)}${phoneNumber.nsn.substring(phoneNumber.nsn.length - 2)}';

    const focusedBorderColor = Colors.purple;

    final defaultPinTheme = PinTheme(
      width: 47,
      height: 47,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 83, 83, 83),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.15),
              const Text(
                "Verification",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    height: 1.2,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Please enter the OTP that we send to the Mobile number $displayPhoneNumber",
                style: const TextStyle(
                    color: Color.fromARGB(255, 212, 212, 212),
                    fontSize: 14,
                    height: 1.2),
              ),
              SizedBox(height: screenHeight * 0.1),
              Container(
                height: 82,
                alignment: Alignment.center,
                child: Form(
                    key: formKey,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        controller: pinController,
                        focusNode: focusNode,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 10),
                        validator: (value) =>
                            value!.length == 6 ? null : 'Invalid OTP',
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) => ref
                            .read(authProvider.notifier)
                            .signInWithPhoneNumber(verificationId, pin),
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          width: 50,
                          height: 50,
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border:
                                Border.all(color: focusedBorderColor, width: 2),
                          ),
                        ),
                        // submittedPinTheme: defaultPinTheme.copyWith(
                        //   decoration: defaultPinTheme.decoration!.copyWith(
                        //     border: Border.all(color: focusedBorderColor),
                        //   ),
                        // ),
                        errorPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                                border: Border.all(color: Colors.redAccent))),
                      ),
                    )),
              ),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Don't you get SMS?",
                    style: TextStyle(
                        color: Color.fromARGB(255, 212, 212, 212),
                        fontSize: 12,
                        height: 1.2)),
                TextSpan(
                    text: isSendOtpCoolDown ? " $timerText" : " Resend Code",
                    style: const TextStyle(
                        color: Colors.purple, fontSize: 12, height: 1.2),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isSendOtpCoolDown = true;
                        });

                        duration = const Duration(minutes: 300);
                        timer = Timer.periodic(const Duration(seconds: 1), (_) {
                          if (duration.inSeconds == 0) {
                            timer.cancel();
                            timerText = '05:00';
                            isSendOtpCoolDown = false;
                          } else {
                            duration -= const Duration(seconds: 1);
                            setState(() {
                              timerText =
                                  '${(duration.inMinutes / 60).floor().toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
                            });
                          }
                        });

                        ref.read(authProvider.notifier).resendOtp(phoneNumber);
                      })
              ])),
              SizedBox(height: screenHeight * 0.1),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(25)),
                          child: TextButton(
                            onPressed: () {
                              focusNode.unfocus();
                              if (formKey.currentState!.validate()) {
                                ref
                                    .read(authProvider.notifier)
                                    .signInWithPhoneNumber(
                                        verificationId, pinController.text);
                              }
                            },
                            child: const Text(
                              'Verify',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))),
                ],
              ),
            ],
          )),
    );
  }
}
