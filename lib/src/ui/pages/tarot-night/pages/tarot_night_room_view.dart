import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/providers/tarot_night_room_view_provider.dart';
import 'package:tata/src/ui/shared/widgets/chat_menu_entry.dart';
import 'package:tata/src/ui/shared/widgets/chat_message_bubble.dart';
import 'package:tata/src/ui/shared/widgets/chat_room_announcement.dart';
import 'package:tata/src/ui/shared/pages/leave_chat_view.dart';
import 'package:tata/src/ui/shared/pages/members_view.dart';
import 'package:tata/src/ui/shared/pages/room_info_view.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:flutter/material.dart';

class TarotNightRoomView extends ConsumerStatefulWidget {
  const TarotNightRoomView({super.key, required this.roomId});

  final String roomId;

  static const routeName = '/tarot-night-room';

  @override
  ConsumerState<TarotNightRoomView> createState() => _TarotNightRoomViewState();
}

class _TarotNightRoomViewState extends ConsumerState<TarotNightRoomView> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final TextEditingController textEditingController = TextEditingController();
    final provider = tarotNightRoomViewProvider(roomId: widget.roomId);

    return ref.watch(provider).when(
          data: (data) => GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
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
                      Text(data.roomInfo.title),
                    ],
                  ),
                  actions: [
                    MenuBar(
                        style: const MenuStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black)),
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
                          color: Colors.black,
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
                                  return snapshot.data != null
                                      ? ChatMessageBubble(
                                          chatMessage: snapshot.data![index])
                                      : null;
                                }
                              },
                              itemCount: snapshot.data?.length,
                            ),
                            stream: data.messageStream,
                          ),
                        ),
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
                                  vertical: 10, horizontal: 10),
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
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                        decoration: const InputDecoration(
                                          hintText: 'Message...',
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 142, 142, 142),
                                              fontSize: 13),
                                          isDense: true,
                                          contentPadding: EdgeInsets.fromLTRB(
                                              15, 11.5, 0, 11.5),
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
                                          onPressed: () {
                                            if (textEditingController
                                                .text.isEmpty) {
                                              return;
                                            }

                                            ref
                                                .read(provider.notifier)
                                                .sendMessage(
                                                    textEditingController.text)
                                                .then((value) {
                                              if (scrollController.offset !=
                                                  0.0) {
                                                scrollController.animateTo(
                                                  scrollController
                                                      .position.minScrollExtent,
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
              )),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const Text('Error'),
        );
  }

  List<ChatMenuEntry> _getMenus(
      BuildContext context, TarotNightRoom chatRoomInfo) {
    final List<ChatMenuEntry> result = <ChatMenuEntry>[
      ChatMenuEntry(
        label: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        menuChildren: <ChatMenuEntry>[
          ChatMenuEntry(
            label: const Text(
              'Room Info',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              context.push(
                  '${TarotNightRoomView.routeName}/${RoomInfoView.routeName}',
                  extra: chatRoomInfo);
            },
          ),
          ChatMenuEntry(
            label: const Text(
              'Members',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              context.push(
                  '${TarotNightRoomView.routeName}/${MembersView.routeName}',
                  extra: chatRoomInfo);
            },
          ),
          ChatMenuEntry(
            label: const Text(
              'Leave Chat',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              context.push(
                  '${TarotNightRoomView.routeName}/${LeaveChatView.routeName}',
                  extra: chatRoomInfo.id);
            },
          ),
        ],
      ),
    ];
    return result;
  }
}
