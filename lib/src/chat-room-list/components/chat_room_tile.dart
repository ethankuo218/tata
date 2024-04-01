import 'package:tata/src/core/tarot.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoomInfo;
  final Function onTap;

  const ChatRoomTile(
      {super.key, required this.chatRoomInfo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String backgroundImage =
        Tarot.getTarotCardImage(chatRoomInfo.backgroundImage);
    return GestureDetector(
        onTap: () => onTap(),
        child: Stack(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  chatRoomInfo.category,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  children: [
                                    Icon(Icons.person,
                                        color: Colors.white.withOpacity(0.8)),
                                    Text(
                                      ' ${chatRoomInfo.members.length}/${chatRoomInfo.limit}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            chatRoomInfo.title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        //   child: Text(
                        //     maxLines: 2,
                        //     overflow: TextOverflow.ellipsis,
                        //     chatRoomInfo.description,
                        //     style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w500,
                        //         color: Colors.white.withOpacity(0.8)),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
