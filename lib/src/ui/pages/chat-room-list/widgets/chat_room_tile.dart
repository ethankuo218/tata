import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/utils/tarot.dart';
import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoomInfo;
  final Function onTap;

  const ChatRoomTile(
      {super.key, required this.chatRoomInfo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String backgroundImage =
        Tarot.getTarotCardImage(chatRoomInfo.backgroundImage!);
    return GestureDetector(
        onTap: () => onTap(),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              border: GradientBoxBorder(
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 241, 189, 88).withOpacity(0.8),
                  const Color.fromARGB(255, 227, 216, 157).withOpacity(0.2),
                  const Color.fromARGB(255, 241, 189, 88).withOpacity(0.8),
                  const Color.fromARGB(255, 227, 216, 157).withOpacity(0.2),
                ]),
                width: 2,
              )),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 244, 185),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              ChatRoomCategory.toText(chatRoomInfo.category),
                              style: const TextStyle(
                                  height: 1.0,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 12, 13, 32)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 12, 13, 32)
                                .withOpacity(0),
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chatRoomInfo.title,
                          style: const TextStyle(
                              height: 25 / 18,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Container(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: [
                                const Icon(Icons.person,
                                    color: Color.fromARGB(255, 255, 244, 185)),
                                const SizedBox(width: 4),
                                Text(
                                  chatRoomInfo.memberCount.toString(),
                                  style: const TextStyle(
                                      height: 24 / 14,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Color.fromARGB(255, 255, 244, 185)),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
