import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tata/src/services/auth/auth_service.dart';
import 'components/animated_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Image.asset('assets/backgrounds/background.png',
              fit: BoxFit.cover),
        )),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.1, sigmaY: 1),
          child: const SizedBox(),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Spacer(),
            SizedBox(
              width: screenWidth,
              child: const Column(children: [
                Text(
                  "TATA",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                      fontFamily: "MedievalSharp",
                      height: 1.2),
                ),
              ]),
            ),
            const Spacer(
              flex: 1,
            ),
            Platform.isIOS
                ? AnimatedButton(
                    brand: Brand.apple,
                    btnAnimationController: _btnAnimationController,
                    onPress: () {
                      AuthService().signInWithApple();
                    },
                  )
                : const SizedBox(),
            AnimatedButton(
              brand: Brand.google,
              btnAnimationController: _btnAnimationController,
              onPress: () {
                AuthService().signInWithGoogle();
              },
            ),
            AnimatedButton(
              brand: Brand.phone,
              btnAnimationController: _btnAnimationController,
              onPress: () {
                Navigator.pushNamed(context, '/phone-verify/phone-input');
              },
            ),
            SizedBox(
              height: screenHeight * 0.09,
            ),
          ]),
        ),
        // ),
        // )
      ],
    ));
  }
}
