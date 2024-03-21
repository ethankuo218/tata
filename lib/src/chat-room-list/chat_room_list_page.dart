import 'package:tata/src/chat-room-list/components/chat_room_category_tile.dart';
import 'package:tata/src/chat-room-list/components/chat_room_tile.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'create_chat_room_dialog.dart';

class ChatRoomListPage extends StatefulWidget {
  const ChatRoomListPage({
    super.key,
  });

  static const routeName = '/chat-room-list';

  @override
  State<ChatRoomListPage> createState() => _ChatRoomListPageState();
}

class _ChatRoomListPageState extends State<ChatRoomListPage> {
  late User user;

  static const categoryList = ['All', 'Interest', 'Emotion', 'Sport', 'Others'];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    late double screenHeight = MediaQuery.of(context).size.height;
    late double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: screenHeight * 0.1,
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    ChatRoomCategoryTile(title: categoryList[index]),
                itemCount: categoryList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 10),
              ),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: StreamBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                ListView.separated(
              itemBuilder: (context, index) {
                var chatRoomInfo =
                    ChatRoom.fromMap(snapshot.data?.docs[index].data());
                return snapshot.connectionState == ConnectionState.waiting
                    ? const LinearProgressIndicator()
                    : ChatRoomTile(
                        chatRoomInfo: chatRoomInfo,
                        onTap: () async => {
                          if (chatRoomInfo.members.contains(user.uid) == false)
                            {await ChatService().joinChatRoom(chatRoomInfo.id)},
                          Navigator.pushNamed(context, '/chat-room',
                              arguments: chatRoomInfo)
                        },
                      );
              },
              itemCount: snapshot.data != null ? snapshot.data.docs.length : 0,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 20),
            ),
            stream: ChatService().getLobbyChatRoomList(),
          ),
        ),
      ]),
      bottomNavigationBar: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              Navigator.pushNamed(context, '/realtime-pair');
            },
            child: Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pair",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          IconButton(
            iconSize: 30,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple),
            ),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
            icon: const Icon(Icons.star_border),
            color: Colors.white,
          ),
          InkWell(
            onTap: () {
              createChatRoomDialog(context, onClosed: (_) {
                if (_ == null) {
                  return;
                }
                ChatService()
                    .createChatRoom(_["title"], _["description"], _["limit"]);
              });
            },
            child: Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
