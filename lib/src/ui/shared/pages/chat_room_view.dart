import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/providers/chat_room_view_provider.dart';
import 'package:tata/src/ui/shared/widgets/chat_menu_entry.dart';
import 'package:tata/src/ui/shared/widgets/chat_message_bubble.dart';
import 'package:tata/src/ui/shared/widgets/chat_room_announcement.dart';
import 'package:tata/src/ui/shared/pages/leave_chat_view.dart';
import 'package:tata/src/ui/shared/pages/members_view.dart';
import 'package:tata/src/ui/shared/pages/room_info_view.dart';
import 'package:tata/src/ui/avatar.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:flutter/material.dart';

class ChatRoomView extends ConsumerWidget {
  const ChatRoomView({super.key, required this.chatRoomId});

  final String chatRoomId;

  static const routeName = '/chat-room';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final TextEditingController textEditingController = TextEditingController();
    final provider = chatRoomViewProvider(roomId: chatRoomId);

    return ref.watch(provider).when(
          data: (data) {
            bool isRealtimeChat = data.roomInfo.type == ChatRoomType.realtime;
            late Member? otherUserInfo;

            if (isRealtimeChat) {
              ref.read(provider.notifier).getOtherUserInfo().then((userInfo) {
                otherUserInfo = userInfo;
              });
            }

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
                                    border: Border.all(
                                        width: 1, color: Colors.white)),
                                child: Image.asset(
                                  Avatar.getAvatarImage(
                                      Avatar.getRandomAvatar()),
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
                                            color: const Color.fromARGB(
                                                255, 223, 130, 255),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                            color: const Color.fromARGB(
                                                255, 241, 198, 255),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                        Expanded(
                            child: Text(
                          isRealtimeChat
                              ? otherUserInfo!.name
                              : data.roomInfo.title,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        )),
                      ],
                    ),
                    actions: [
                      MenuBar(
                          style: const MenuStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.transparent),
                          ),
                          children: ChatMenuEntry.build(
                              _getMenus(context, data.roomInfo)))
                    ],
                    centerTitle: false,
                    titleSpacing: 0,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                          child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 12, 13, 32),
                                  Color.fromARGB(255, 26, 0, 58)
                                ],
                              ),
                            ),
                            child: StreamBuilder(
                              builder: (BuildContext context,
                                      AsyncSnapshot<List<Message>> snapshot) =>
                                  ListView.builder(
                                reverse: true,
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  if (snapshot.connectionState !=
                                      ConnectionState.active) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    Message? nextMessage = index - 1 >= 0
                                        ? snapshot.data![index - 1]
                                        : null;
                                    Message? lastMessage =
                                        index + 1 <= snapshot.data!.length - 1
                                            ? snapshot.data![index + 1]
                                            : null;

                                    return snapshot.data != null
                                        ? ChatMessageBubble(
                                            chatMessage: snapshot.data![index],
                                            isLastMsgSentBySameUser:
                                                lastMessage == null
                                                    ? false
                                                    : lastMessage.senderId ==
                                                        snapshot.data![index]
                                                            .senderId,
                                            isNextMsgSentBySameUser:
                                                nextMessage == null
                                                    ? false
                                                    : nextMessage.senderId ==
                                                        snapshot.data![index]
                                                            .senderId,
                                          )
                                        : null;
                                  }
                                },
                                itemCount: snapshot.data?.length,
                              ),
                              stream: data.messageStream,
                            ),
                          ),
                          if (data.roomInfo.type == ChatRoomType.normal)
                            ChatRoomAnnouncement(
                                announcement: data.roomInfo.description)
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 35.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(0.15),
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                              left: Radius.elliptical(24, 24),
                                              right: Radius.elliptical(24, 24)),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(width: 10),
                                        Expanded(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 5,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            hintText: 'Message...',
                                            hintStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                8, 12, 8, 12),
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
                                            icon: const FaIcon(FontAwesomeIcons
                                                .solidPaperPlane),
                                            onPressed: () {
                                              if (textEditingController
                                                  .text.isEmpty) {
                                                return;
                                              }

                                              ref
                                                  .read(provider.notifier)
                                                  .sendMessage(
                                                      textEditingController
                                                          .text)
                                                  .then((value) {
                                                if (scrollController.offset !=
                                                    0.0) {
                                                  scrollController.animateTo(
                                                    scrollController.position
                                                        .minScrollExtent,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeOut,
                                                  );
                                                }

                                                textEditingController.clear();
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const Text('Error'),
        );
  }

  List<ChatMenuEntry> _getMenus(BuildContext context, ChatRoom chatRoomInfo) {
    final List<ChatMenuEntry> result = <ChatMenuEntry>[
      ChatMenuEntry(
        label: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        menuChildren: <ChatMenuEntry>[
          if (chatRoomInfo.type == ChatRoomType.normal)
            ChatMenuEntry(
              label: const Text(
                'Room Info',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                context.push('$routeName/${RoomInfoView.routeName}',
                    extra: chatRoomInfo);
              },
            ),
          if (chatRoomInfo.type == ChatRoomType.normal)
            ChatMenuEntry(
              label: const Text(
                'Members',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                context.push('$routeName/${MembersView.routeName}',
                    extra: chatRoomInfo.id);
              },
            ),
          ChatMenuEntry(
            label: const Text(
              'Leave Chat',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              context.push('$routeName/${LeaveChatView.routeName}',
                  extra: chatRoomInfo.id);
            },
          ),
        ],
      ),
    ];
    return result;
  }
}
