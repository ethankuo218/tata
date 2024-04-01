import 'package:flutter/material.dart';
import 'package:tata/src/models/chat_room.dart';

Future<Object?> createChatRoomDetailDialog(BuildContext context,
    {required ChatRoom chatRoomInfo, required ValueChanged onClosed}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Chat room detail",
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
              height: screenHeight * 0.6,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 30, 30, 30),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/death.jpg'),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                  bottom: Radius.zero),
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
                                  top: Radius.circular(10),
                                  bottom: Radius.zero),
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
                                          print('close dialog');
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        child: Container(
                                          height: screenWidth * 0.08,
                                          width: screenWidth * 0.08,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.6),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.person,
                              color: Colors.white.withOpacity(0.4)),
                          const SizedBox(width: 5),
                          Text(chatRoomInfo.members.length.toString(),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 16))
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('Description',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    Container(
                        height: screenHeight * 0.2,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Scrollbar(
                            child: SingleChildScrollView(
                          child: Text(chatRoomInfo.description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                        ))),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Join chat room'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )).then(onClosed);
}
