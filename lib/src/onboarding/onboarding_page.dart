import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'components/animated_button.dart';
import 'custom_sign_in_dialog.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
            height: screenHeight,
            left: screenWidth * -0.465,
            child: Image.asset('assets/Backgrounds/Background.png')),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.1, sigmaY: 1),
          child: const SizedBox(),
        )),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 240),
          top: isSignInDialogShown ? -50 : 0,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      width: 260,
                      child: Column(children: [
                        Text(
                          "TATA",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 70,
                              fontFamily: "Poppins",
                              height: 1.2),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ]),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    // AnimatedButton(
                    //   btnAnimationController: _btnAnimationController,
                    //   press: () {
                    //     _btnAnimationController.isActive = true;
                    //     Future.delayed(const Duration(milliseconds: 800), () {
                    //       setState(() {
                    //         isSignInDialogShown = true;
                    //       });
                    //       customSignInDialog(context, onClosed: (_) {
                    //         setState(() {
                    //           isSignInDialogShown = false;
                    //         });
                    //       });
                    //     });
                    //   },
                    // ),
                    SizedBox(
                      height: screenHeight * 0.15,
                    ),
                  ]),
            ),
          ),
        )
      ],
    ));
  }
}
