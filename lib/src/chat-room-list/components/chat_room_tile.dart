import 'package:tata/src/models/chat_room.dart';
import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoomInfo;
  final Function onTap;

  const ChatRoomTile(
      {super.key, required this.chatRoomInfo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/the_fool.jpeg'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                opacity: 0.8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        InkWell(
          splashColor: Colors.white,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () => onTap(),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 201, 201, 201).withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatRoomInfo.title,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          // chatRoomInfo.latestMessage?.message ??
                          //     "No messages yet",
                          chatRoomInfo.description,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 50, 50, 50)),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 2.0),
                          minimumSize: Size.zero,
                          backgroundColor:
                              const Color.fromARGB(255, 156, 39, 176),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () => {
                              Navigator.pushNamed(context, '/chat-room',
                                  arguments: chatRoomInfo)
                            },
                        child: const Text("Join",
                            style: TextStyle(color: Colors.white))),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
