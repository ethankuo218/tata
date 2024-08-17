import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tata/src/core/providers/auth_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PhoneVerifyInputView extends ConsumerStatefulWidget {
  const PhoneVerifyInputView({super.key});

  static const routeName = '/phone-verify/input';

  @override
  ConsumerState<PhoneVerifyInputView> createState() =>
      _PhoneVerifyInputViewState();
}

class _PhoneVerifyInputViewState extends ConsumerState<PhoneVerifyInputView> {
  final GlobalKey<FormFieldState<PhoneNumber>> phoneNumberInputKey =
      GlobalKey<FormFieldState<PhoneNumber>>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.15),
              const Text(
                "Welcome!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    height: 1.2,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: screenHeight * 0.01),
              const Text(
                "Enter your phone number to get started",
                style: TextStyle(
                    color: Color.fromARGB(255, 212, 212, 212),
                    fontSize: 14,
                    height: 1.2),
              ),
              SizedBox(height: screenHeight * 0.1),
              PhoneFormField(
                key: phoneNumberInputKey,
                initialValue:
                    PhoneNumber.parse('+886'), // or use the controller
                validator: PhoneValidator.compose([
                  PhoneValidator.required(context),
                  PhoneValidator.validMobile(context)
                ]),
                countrySelectorNavigator:
                    const CountrySelectorNavigator.bottomSheet(),
                enabled: true,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                isCountrySelectionEnabled: true,
                isCountryButtonPersistent: true,
                countryButtonStyle: const CountryButtonStyle(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    showDialCode: true,
                    showIsoCode: true,
                    showFlag: true,
                    flagSize: 16),
              ),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "By Continuing. I agree with",
                    style: TextStyle(
                        color: Color.fromARGB(255, 212, 212, 212),
                        fontSize: 12,
                        height: 1.2)),
                TextSpan(
                    text: " Terms & Conditions",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 228, 85),
                        fontSize: 12,
                        height: 1.2),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launchUrlString("https://www.google.com"))
              ])),
              SizedBox(height: screenHeight * 0.1),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 228, 85),
                              borderRadius: BorderRadius.circular(25)),
                          child: TextButton(
                            onPressed: () async {
                              if (!context.mounted) {
                                return;
                              }

                              PhoneNumber? phoneNumber =
                                  phoneNumberInputKey.currentState!.value;

                              if (phoneNumberInputKey.currentState!
                                      .validate() &&
                                  phoneNumber != null) {
                                await ref
                                    .read(authProvider.notifier)
                                    .sendOtp(phoneNumber);
                              }
                            },
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 7, 9, 47),
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
