import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:tata/src/core/providers/auth_provider.dart';
import 'package:tata/src/ui/pages/auth/phone_verify_input_page.dart';
import 'widgets/animated_button.dart';
import 'package:flutter/src/painting/gradient.dart' as flutter_ui;

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: flutter_ui.LinearGradient(
          colors: [
            Color.fromARGB(255, 12, 13, 32),
            Color.fromARGB(255, 26, 0, 58)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/bg-star.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(flex: 3, child: SizedBox()),
            Stack(alignment: Alignment.center, children: [
              Container(
                  height: 208,
                  width: 208,
                  decoration: BoxDecoration(
                    gradient: flutter_ui.RadialGradient(colors: [
                      const Color.fromARGB(255, 255, 195, 79).withOpacity(0),
                      const Color.fromARGB(255, 255, 195, 79)
                          .withOpacity(0.025),
                      const Color.fromARGB(255, 255, 195, 79).withOpacity(0.2)
                    ], stops: const [
                      0,
                      0.7,
                      1
                    ]),
                    shape: BoxShape.circle,
                  )),
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  child: SvgPicture.asset('assets/images/logo.svg'),
                ),
              ),
            ]),
            const Expanded(flex: 1, child: SizedBox()),
            if (Platform.isIOS)
              AnimatedButton(
                  brand: Brand.apple,
                  btnAnimationController: _btnAnimationController,
                  onPress: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });

                    ref
                        .read(authProvider.notifier)
                        .signInWithApple()
                        .catchError((error) => context.pop());
                  }),
            AnimatedButton(
                brand: Brand.google,
                btnAnimationController: _btnAnimationController,
                onPress: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });

                  ref
                      .read(authProvider.notifier)
                      .signInWithGoogle()
                      .catchError((error) => context.pop());
                }),
            AnimatedButton(
              brand: Brand.phone,
              btnAnimationController: _btnAnimationController,
              onPress: () => context.push(PhoneVerifyInputView.routeName),
            ),
            const Expanded(flex: 2, child: SizedBox())
          ]),
    ));
  }
}
