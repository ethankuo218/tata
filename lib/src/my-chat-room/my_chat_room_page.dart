import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/chat-room/chat_room_page.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/my-chat-room/components/my_chat_room_tile.dart';
import 'package:tata/src/services/chat.service.dart';

class MyChatRoomPage extends StatefulWidget {
  const MyChatRoomPage({super.key});

  static const routeName = '/my-chat-room';

  @override
  State<StatefulWidget> createState() {
    return _MyChatRoomPageState();
  }
}

class _MyChatRoomPageState extends State<MyChatRoomPage> {
  late User user;
  late bool isLoading = false;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                ListView.separated(
              itemBuilder: (context, index) {
                var chatRoomInfo =
                    ChatRoom.fromMap(snapshot.data?.docs[index].data());
                return MyChatRoomTile(
                    userUid: user.uid,
                    chatRoomInfo: chatRoomInfo,
                    onTap: () {
                      Navigator.pushNamed(context, ChatRoomPage.routeName,
                          arguments: chatRoomInfo);
                    });
              },
              itemCount: snapshot.data != null ? snapshot.data.docs.length : 0,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 15),
            ),
            stream: ChatService().getUserChatRoomList(),
          ))
        ],
      ),
    ));
  }
}
