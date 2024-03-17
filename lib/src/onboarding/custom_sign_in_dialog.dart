import 'package:eq_chat/src/chat-room-list/chat_room_list_page.dart';
import 'package:eq_chat/src/onboarding/components/brand_button.dart';
import 'package:eq_chat/src/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

Future<Object?> customSignInDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign up",
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween =
            Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => Center(
            child: Container(
              height: 520,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset:
                    false, // avoid overflow error when keyboard shows up
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Access to 240+ hours of content. Learn design and code, by builder real apps with Flutter and Swift.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16)),
                      BrandButton(
                        brand: Brand.apple,
                        onPress: () => AuthService().signInWithApple(),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      BrandButton(
                        brand: Brand.google,
                        onPress: () async {
                          await AuthService().signInWithGoogle();
                          if (!context.mounted) return;

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChatRoomListPage()));
                        },
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      BrandButton(
                        brand: Brand.phone,
                        onPress: () => AuthService().signInWithPhoneNumber(),
                      ),
                    ]),
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: -48,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )).then(onClosed);
}
