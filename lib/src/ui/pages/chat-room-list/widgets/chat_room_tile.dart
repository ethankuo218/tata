import 'package:flutter_svg/flutter_svg.dart';
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
        child: Stack(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/images/star_2.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                      Color.fromARGB(255, 255, 195, 79), BlendMode.srcIn)),
              SvgPicture.asset('assets/images/star_2.svg',
                  width: 12,
                  height: 12,
                  colorFilter: const ColorFilter.mode(
                      Color.fromARGB(255, 255, 195, 79), BlendMode.srcIn)),
              const SizedBox(width: 11),
              Expanded(
                  child: Container(
                height: 120,
                padding: const EdgeInsets.fromLTRB(72, 16, 16, 16),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color.fromARGB(255, 255, 244, 185).withOpacity(0.3),
                      const Color.fromARGB(255, 255, 244, 185).withOpacity(0.2),
                      const Color.fromARGB(255, 255, 244, 185).withOpacity(0.1),
                    ]),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(20)),
                    border: GradientBoxBorder(
                      gradient: LinearGradient(colors: [
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
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Opacity(
                                opacity: 0.5,
                                child: SvgPicture.asset(
                                    'assets/images/star_2.svg',
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(255, 255, 195, 79),
                                        BlendMode.srcIn))),
                            const SizedBox(width: 8),
                            Text(
                              ChatRoomCategory.toText(
                                  context, chatRoomInfo.category),
                              style: const TextStyle(
                                  height: 25 / 18,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 195, 79)),
                            ),
                            const SizedBox(width: 8),
                            Opacity(
                                opacity: 0.5,
                                child: SvgPicture.asset(
                                    'assets/images/star_2.svg',
                                    width: 16,
                                    height: 16,
                                    colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(255, 255, 195, 79),
                                        BlendMode.srcIn))),
                          ],
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
                    const SizedBox(height: 8),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      chatRoomInfo.title,
                      style: const TextStyle(
                          height: 25 / 18,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ))
            ],
          ),
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 255, 195, 79), width: 2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                image: DecorationImage(
                    image: AssetImage(backgroundImage), fit: BoxFit.cover)),
          ),
        ]));
  }
}
