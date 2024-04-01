import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/chat-room-list/chat_room_detail_dialog.dart';
import 'package:tata/src/chat-room-list/components/chat_room_list_shimmer.dart';
import 'package:tata/src/chat-room-list/components/chat_room_tile.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/services/chat_service.dart';
import 'package:tata/src/services/snackbar.service.dart';

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

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: isLoading
              ? const ChatRoomListShimmer()
              : StreamBuilder(
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                          ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      var chatRoomInfo =
                          ChatRoom.fromMap(snapshot.data?.docs[index].data());
                      return ChatRoomTile(
                          chatRoomInfo: chatRoomInfo,
                          onTap: () => createChatRoomDetailDialog(context,
                                  chatRoomInfo: chatRoomInfo, onClosed: (_) {
                                if (_ == null) {
                                  return;
                                }

                                if (chatRoomInfo.members.length <=
                                    chatRoomInfo.limit) {
                                  SnackbarService().showSnackBar(
                                      context: context,
                                      text: 'Chat room is full');
                                  return;
                                }

                                ChatService().joinChatRoom(chatRoomInfo.id);
                              }));
                    },
                    itemCount:
                        snapshot.data != null ? snapshot.data.docs.length : 0,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 20),
                  ),
                  stream: ChatService().getLobbyChatRoomList(),
                )),
    );
  }
}
