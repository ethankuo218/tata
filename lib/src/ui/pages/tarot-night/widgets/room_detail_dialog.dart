import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';

Future<Object?> showTarotNightRoomDetailDialog(BuildContext context,
    {required TarotNightRoom roomInfo, required ValueChanged onClosed}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, _, __) => DefaultTextStyle(
      style: const TextStyle(),
      child: Center(
        child: Container(
          height: 400,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 12, 13, 32),
              border:
                  Border.all(color: const Color.fromARGB(255, 241, 198, 255)),
              borderRadius: const BorderRadius.all(Radius.circular(28))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: Colors.white,
                      )),
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
              Text(
                roomInfo.description,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    height: 12 / 7,
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(244, 223, 130, 255),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("立即參與",
                      style: TextStyle(
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
