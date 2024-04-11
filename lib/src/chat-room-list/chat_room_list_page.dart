import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tata/src/chat-room-list/chat_room_detail_dialog.dart';
import 'package:tata/src/chat-room-list/components/chat_room_list_shimmer.dart';
import 'package:tata/src/chat-room-list/components/chat_room_tile.dart';
import 'package:tata/src/chat-room/chat_room_page.dart';
import 'package:tata/src/core/tarot.dart';
import 'package:tata/src/create-chat-room/create_chat_room_bottom_sheet.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/models/route_argument.dart';
import 'package:tata/src/services/chat.service.dart';
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
          GestureDetector(
            onTap: () {
              showCreateChatRoomBottomSheet(context, onClosed: (_) {
                if (_ == null) {
                  return;
                }
                ChatService().createChatRoom(
                    category: _["category"],
                    title: _["title"],
                    description: _["description"],
                    backgroundImage: Tarot.getRandomCard(),
                    limit: _["limit"] ?? 2);
              });
            },
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
                              onTap: () => showChatRoomDetailDialog(context,
                                      chatRoomInfo: chatRoomInfo,
                                      onClosed: (_) {
                                    if (_ == null) {
                                      return;
                                    }

                                    ChatService()
                                        .joinChatRoom(chatRoomInfo)
                                        .then((value) {
                                      Navigator.of(context).pushNamed(
                                          ChatRoomPage.routeName,
                                          arguments: ChatRoomArgument(
                                              chatRoomInfo: chatRoomInfo));
                                    }).onError<Exception>((error, stackTrace) {
                                      SnackbarService().showSnackBar(
                                          context: context,
                                          message: error.toString());
                                    }).catchError((e) {
                                      SnackbarService().showSnackBar(
                                          context: context,
                                          message:
                                              'Unknown error: Please contact the support team');
                                    });
                                  }));
                        },
                        itemCount: chatRoomList.data != null
                            ? chatRoomList.data!.length
                            : 0,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 20),
                      ),
                      stream: ChatService().getLobbyChatRoomList(),
                    ))
        ],
      ),
    ));
  }
}
