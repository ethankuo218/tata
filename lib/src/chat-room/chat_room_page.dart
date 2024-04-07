import 'package:tata/src/chat-room/components/chat_menu_entry.dart';
import 'package:tata/src/chat-room/components/chat_message_bubble.dart';
import 'package:tata/src/core/avatar.dart';
import 'package:tata/src/models/app_user_info.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/models/message.dart';
import 'package:tata/src/models/route_argument.dart';
import 'package:tata/src/services/chat.service.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final ChatRoomArgument args;

  const ChatRoomPage({super.key, required this.args});

  static const routeName = '/chat-room';

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isExpanded = false;
  late ChatRoom chatRoomInfo;
  late AppUserInfo? otherUserInfo;

  @override
  void initState() {
    super.initState();

    chatRoomInfo = widget.args.chatRoomInfo;
    otherUserInfo = widget.args.otherUserInfo;
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final isRealtimeChat = chatRoomInfo.type == ChatRoomType.realtime;

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isRealtimeChat
                    ? Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 1, color: Colors.white)),
                        child: Image.asset(
                          Avatar.getAvatarImage(Avatar.getRandomAvatar()),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Stack(
                        children: [
                          SizedBox(
                            width: 44,
                            height: 44,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.8),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Image.asset(
                                    'assets/avatars/the_magician.png',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 44,
                            height: 44,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.8),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Image.asset(
                                    'assets/avatars/the_magician.png',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          )
                        ],
                      ),
                const SizedBox(width: 15),
                Text(isRealtimeChat ? otherUserInfo!.name : chatRoomInfo.title),
              ],
            ),
            actions: [
              MenuBar(
                  style: const MenuStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  children: ChatMenuEntry.build(_getMenus(chatRoomInfo.type)))
            ],
            centerTitle: false,
            titleSpacing: 0,
          ),
          body: Column(
            children: [
              _buildMessageList(
                chatRoomInfo.type,
                scrollController,
              ),
              _buildChatRoomInputBar(scrollController),
            ],
          ),
        ));
  }

  Widget _buildMessageList(
      ChatRoomType type, ScrollController scrollController) {
    return Expanded(
        child: Stack(
      children: [
        Container(
          color: Colors.black,
          child: StreamBuilder(
            builder:
                (BuildContext context, AsyncSnapshot<List<Message>> snapshot) =>
                    ListView.builder(
              reverse: true,
              controller: scrollController,
              itemBuilder: (context, index) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return const LinearProgressIndicator();
                } else {
                  return snapshot.data != null
                      ? ChatMessageBubble(chatMessage: snapshot.data![index])
                      : null;
                }
              },
              itemCount: snapshot.data?.length,
            ),
            stream: ChatService().getMessages(chatRoomInfo.id),
          ),
        ),
        if (type == ChatRoomType.normal)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: isExpanded ? null : 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 41, 41, 41),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.campaign, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(
                    chatRoomInfo.description,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    maxLines: isExpanded ? null : 1,
                  )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      icon: isExpanded
                          ? const Icon(
                              Icons.expand_less,
                              color: Colors.white,
                              size: 20,
                            )
                          : const Icon(Icons.expand_more,
                              color: Colors.white, size: 20))
                ],
              ),
            ),
          )
      ],
    ));
  }

  Widget _buildChatRoomInputBar(ScrollController scrollController) {
    final textEditingController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 35.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(179, 41, 41, 41),
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.elliptical(23, 23),
                        right: Radius.elliptical(23, 23)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                          child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Message...',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 142, 142, 142),
                              fontSize: 13),
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(15, 11.5, 0, 11.5),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        controller: textEditingController,
                      )),
                      SizedBox(
                        height: 45,
                        width: 60,
                        child: IconButton(
                          padding: const EdgeInsets.all(0.0),
                          color: Colors.white,
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            if (textEditingController.text.isEmpty) {
                              return;
                            }

                            await ChatService().sendMessage(
                              chatRoomInfo.id,
                              textEditingController.text,
                            );

                            if (scrollController.offset != 0.0) {
                              scrollController.animateTo(
                                scrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }

                            textEditingController.clear();
                          },
                        ),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  List<ChatMenuEntry> _getMenus(ChatRoomType type) {
    final List<ChatMenuEntry> result = <ChatMenuEntry>[
      ChatMenuEntry(
        label: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        menuChildren: <ChatMenuEntry>[
          if (type == ChatRoomType.normal)
            ChatMenuEntry(
              label: const Text(
                'Room Info',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/room-info', arguments: chatRoomInfo);
              },
            ),
          if (type == ChatRoomType.normal)
            ChatMenuEntry(
              label: const Text(
                'Members',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/members', arguments: chatRoomInfo);
              },
            ),
          ChatMenuEntry(
            label: const Text(
              'Leave Chat',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/leave-chat', arguments: chatRoomInfo.id);
            },
          ),
        ],
      ),
    ];
    return result;
  }
}
