import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';

Future<Object?> showTarotNightRoomDetailDialog(BuildContext context,
    {required TarotNightRoom roomInfo, required ValueChanged onClosed}) {
  final bool isHost = roomInfo.hostId == FirebaseAuth.instance.currentUser!.uid;
  final bool isFull = roomInfo.memberCount == 5;

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, _, __) => DefaultTextStyle(
      style: const TextStyle(),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(minHeight: 400, maxHeight: 600),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 12, 13, 32),
              border: Border.all(
                  color: const Color.fromARGB(255, 241, 198, 255), width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(28))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: FaIcon(
                        FontAwesomeIcons.xmark,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(
                roomInfo.title,
                style: const TextStyle(
                    height: 1.0,
                    color: Color.fromARGB(255, 241, 198, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SvgPicture.asset(
                      "assets/images/star_3.svg",
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.4), BlendMode.srcIn),
                    ),
                    const SizedBox(width: 4),
                    const Text('主題：',
                        style: TextStyle(
                            height: 1.15,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 198, 255)
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        TarotNightRoomTheme.toText(roomInfo.theme),
                        style: const TextStyle(
                            height: 12 / 7,
                            color: Color.fromARGB(255, 241, 198, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    SvgPicture.asset(
                      "assets/images/star_3.svg",
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.4), BlendMode.srcIn),
                    ),
                    const SizedBox(width: 4),
                    const Text('人數：',
                        style: TextStyle(
                            height: 1.15,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(width: 8),
                    const FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      roomInfo.memberCount.toString(),
                      style: const TextStyle(
                          height: 1.15,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )
                  ]),
                ],
              ),
              const SizedBox(height: 20),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SvgPicture.asset(
                  "assets/images/star_3.svg",
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.4), BlendMode.srcIn),
                ),
                const SizedBox(width: 4),
                const Text('房主的心事分享',
                    style: TextStyle(
                        height: 1.15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ]),
              const SizedBox(height: 20),
              Container(
                constraints: const BoxConstraints(minHeight: 120),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 198, 255)
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  roomInfo.description,
                  maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      height: 12 / 7,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(244, 223, 130, 255),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    if (isFull) {
                      return;
                    }
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                      isFull
                          ? "房間已滿"
                          : isHost
                              ? "回到聊天室"
                              : "立即參與",
                      style: const TextStyle(
                          height: 1.2,
                          color: Color.fromARGB(255, 12, 13, 32),
                          fontSize: 16,
                          fontWeight: FontWeight.w500))),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
    barrierLabel: "Tarot Night Room Detail",
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
