import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tata/src/chat-room-list/chat_room_list_controller.dart';
import 'package:tata/src/chat-room-list/components/chat_room_list_shimmer.dart';
import 'package:tata/src/chat-room-list/components/chat_room_tile.dart';
import 'package:tata/src/models/chat_room.dart';

class ChatRoomListView extends StatefulWidget {
  const ChatRoomListView({super.key, required this.controller});

  final ChatRoomListController controller;

  @override
  State<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
  late User user;
  late bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // widget.controller.init(context);
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => widget.controller.createChatRoom(context),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(18)),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: isLoading
                  ? const ChatRoomListShimmer()
                  : StreamBuilder(
                      builder: (BuildContext context,
                              AsyncSnapshot<List<ChatRoom>> chatRoomList) =>
                          ListView.separated(
                        itemBuilder: (context, index) {
                          var chatRoomInfo = chatRoomList.data![index];
                          return ChatRoomTile(
                              chatRoomInfo: chatRoomInfo,
                              onTap: () => widget.controller
                                  .onChatRoomTilePressed(
                                      context, chatRoomInfo));
                        },
                        itemCount: chatRoomList.data != null
                            ? chatRoomList.data!.length
                            : 0,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 20),
                      ),
                      stream: widget.controller.lobbyListStream,
                    ))
        ],
      ),
    ));
  }
}
