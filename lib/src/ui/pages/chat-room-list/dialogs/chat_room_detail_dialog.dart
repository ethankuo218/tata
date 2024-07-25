import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/utils/tarot.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<Object?> showChatRoomDetailDialog(BuildContext context,
    {required ChatRoom chatRoomInfo, required ValueChanged onClosed}) {
  late bool isHost =
      chatRoomInfo.hostId == FirebaseAuth.instance.currentUser!.uid;
  late bool isFull = chatRoomInfo.memberCount == chatRoomInfo.limit;

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, _, __) => DefaultTextStyle(
      style: const TextStyle(),
      child: Center(
        child: Container(
          height: 541,
          width: 361,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 12, 13, 32),
              border: Border.all(
                  color: const Color.fromARGB(255, 255, 244, 185), width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(40))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Tarot.getTarotCardImage(
                          chatRoomInfo.backgroundImage!)),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color.fromARGB(255, 241, 189, 88)
                                .withOpacity(0.8),
                            const Color.fromARGB(255, 227, 216, 157)
                                .withOpacity(0.2),
                            const Color.fromARGB(255, 241, 189, 88)
                                .withOpacity(0.8),
                            const Color.fromARGB(255, 227, 216, 157)
                                .withOpacity(0.2),
                          ]),
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 80),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color.fromARGB(255, 12, 13, 32).withOpacity(0),
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 244, 185),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              ChatRoomCategory.toText(
                                  context, chatRoomInfo.category),
                              style: const TextStyle(
                                  height: 1.1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 12, 13, 32)),
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Row(
                              children: [
                                const Icon(Icons.person,
                                    color: Color.fromARGB(255, 255, 244, 185)),
                                const SizedBox(width: 4),
                                Text(chatRoomInfo.memberCount.toString(),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 244, 185),
                                        fontSize: 14)),
                              ],
                            ))
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('- ${chatRoomInfo.title} -',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '- ${AppLocalizations.of(context)!.home_dialog_description} -',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                  height: 99,
                  child: Scrollbar(
                      child: SingleChildScrollView(
                    child: Text(chatRoomInfo.description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                  ))),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            WidgetStateProperty.all<Size>(const Size(136, 40)),
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                        ),
                        backgroundColor: isFull
                            ? WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 168, 168, 168))
                            : WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 255, 195, 79)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        textStyle:
                            WidgetStateProperty.all<TextStyle>(const TextStyle(
                          height: 1.0,
                          color: Color.fromARGB(255, 24, 24, 24),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                      onPressed: () {
                        if (isFull) {
                          return;
                        }

                        context.pop(true);
                      },
                      child: Text(
                        isFull
                            ? AppLocalizations.of(context)!.common_room_is_full
                            : isHost
                                ? AppLocalizations.of(context)!
                                    .common_room_back_to_room
                                : AppLocalizations.of(context)!
                                    .common_room_join_now,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 24, 24, 24),
                            height: 1.2,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
    barrierLabel: "Chat Room Detail",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
          position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child);
    },
  ).then(onClosed);
}
