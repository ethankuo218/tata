import 'package:flutter/material.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/ui/tarot.dart';

class RoomInfoView extends StatelessWidget {
  final ChatRoom chatRoomInfo;
  const RoomInfoView({super.key, required this.chatRoomInfo});

  static const String routeName = 'room-info';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Info'),
      ),
      body: Container(
        height: screenHeight,
        decoration: const BoxDecoration(color: Color.fromARGB(255, 30, 30, 30)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      height: screenHeight * 0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(Tarot.getTarotCardImage(
                            chatRoomInfo.backgroundImage!)),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      )),
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
                    height: screenHeight * 0.3,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10), bottom: Radius.zero),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
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
                            width: 2, color: Colors.purple.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(chatRoomInfo.category,
                            style: const TextStyle(
                                color: Colors.purple, fontSize: 16)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
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
                  height: screenHeight * 0.18,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Scrollbar(
                      child: SingleChildScrollView(
                    child: Text(chatRoomInfo.description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
