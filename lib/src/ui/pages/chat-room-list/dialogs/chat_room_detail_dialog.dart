import 'package:flutter/material.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/utils/tarot.dart';

Future<Object?> showChatRoomDetailDialog(BuildContext context,
    {required ChatRoom chatRoomInfo, required ValueChanged onClosed}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, _, __) => DefaultTextStyle(
      style: const TextStyle(),
      child: Center(
        child: Container(
          height: screenHeight * 0.6,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 7, 9, 47),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Tarot.getTarotCardImage(
                              chatRoomInfo.backgroundImage!)),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10), bottom: Radius.zero),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.0),
                          ],
                        ),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10), bottom: Radius.zero),
                      ))),
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10), bottom: Radius.zero),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Container(
                                    height: screenWidth * 0.08,
                                    width: screenWidth * 0.08,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text(chatRoomInfo.title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 255, 228, 85)
                                .withOpacity(0.8)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(chatRoomInfo.category,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 228, 85),
                                fontSize: 16)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        children: [
                          Icon(Icons.person,
                              color: Colors.white.withOpacity(0.4)),
                          const SizedBox(width: 5),
                          Text(
                              '${chatRoomInfo.memberCount.toString()}/${chatRoomInfo.limit}',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 16)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text('心情描述',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              Container(
                  height: screenHeight * 0.18,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Scrollbar(
                      child: SingleChildScrollView(
                    child: Text(chatRoomInfo.description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                  ))),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('立即參與話題'))
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
