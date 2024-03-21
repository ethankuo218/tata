import 'package:tata/src/chat-room/components/chat_message_bubble.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/services/chat_service.dart';
import 'package:flutter/material.dart';
import '../models/message.dart';

class ChatRoomPage extends StatelessWidget {
  final ChatRoom chatRoomInfo;

  const ChatRoomPage({super.key, required this.chatRoomInfo});

  static const routeName = '/chat-room';

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(chatRoomInfo.title),
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
        child: StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) =>
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(179, 45, 45, 45),
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
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 142, 142, 142),
                            fontSize: 13),
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(15, 11.5, 0, 11.5),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          // borderSide: BorderSide()
                        ),
                      ),
                      controller: textEditingController,
                    )),
                    SizedBox(
                      // Container(
                      height: 45,
                      width: 60,
                      // decoration: BoxDecoration(border: Border.all()),
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
          )
        ],
      ),
    );
  }
}
