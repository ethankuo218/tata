import 'package:tata/src/chat-room/components/chat_message_bubble.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/services/chat.service.dart';
import 'package:flutter/material.dart';
import '../models/message.dart';

class ChatRoomPage extends StatefulWidget {
  final ChatRoom chatRoomInfo;

  const ChatRoomPage({super.key, required this.chatRoomInfo});

  static const routeName = '/chat-room';

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.chatRoomInfo.title,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 41, 41, 41),
          ),
          body: Column(
            children: [
              _buildMessageList(scrollController),
              _buildChatRoomInputBar(scrollController),
            ],
          ),
        ));
  }

  Widget _buildMessageList(ScrollController scrollController) {
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
            stream: ChatService().getMessages(widget.chatRoomInfo.id),
          ),
        ),
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
                  '', // TODO: change to actual message
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
              color: const Color.fromARGB(255, 41, 41, 41),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(179, 0, 0, 0),
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
                              widget.chatRoomInfo.id,
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
}
