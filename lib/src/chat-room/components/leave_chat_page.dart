import 'package:flutter/material.dart';
import 'package:tata/src/home/home_page.dart';
import 'package:tata/src/services/chat.service.dart';

class LeaveChatPage extends StatelessWidget {
  final String chatRoomId;
  const LeaveChatPage({super.key, required this.chatRoomId});

  static const routeName = '/leave-chat';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Chat'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.15, horizontal: 60.0),
          child: Column(
            children: [
              const Text('Do you want to leave this chat ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              SizedBox(height: screenHeight * 0.1),
              TextButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    ChatService().leaveChatRoom(chatRoomId).then((_) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomePage.routeName, (Route<dynamic> route) => false);
                    });
                  },
                  child: const Text('Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
