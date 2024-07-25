import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/tarot_night_message.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/providers/pages/tarot-night/room_view_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_info_view.dart';
import 'package:tata/src/ui/shared/widgets/chat_menu_entry.dart';
import 'package:tata/src/ui/shared/pages/members_view.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/tarot_night_announcement.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/tarot_night_message_bubble.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TarotNightRoomView extends ConsumerStatefulWidget {
  const TarotNightRoomView({super.key, required this.roomId});

  final String roomId;

  static const routeName = '/tarot-night/room';

  @override
  ConsumerState<TarotNightRoomView> createState() => _TarotNightRoomViewState();
}

class _TarotNightRoomViewState extends ConsumerState<TarotNightRoomView> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  late TarotNightRoomViewProvider provider;

  @override
  void initState() {
    super.initState();
    provider = tarotNightRoomViewProvider(roomId: widget.roomId);

    scrollController.addListener(() {
      if (scrollController.offset == 0.0) {
        ref.read(provider.notifier).markAsRead();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(provider).when(
          data: (data) => GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 12, 13, 32),
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
                                    color: const Color.fromARGB(
                                        255, 223, 130, 255),
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
                                    color: const Color.fromARGB(
                                        255, 241, 198, 255),
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
                      Expanded(child: Text(data.roomInfo.title))
                    ],
                  ),
                  actions: [
                    MenuBar(
                        style: const MenuStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.zero),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 12, 13, 32))),
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
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(255, 12, 13, 32),
                                Color.fromARGB(255, 26, 0, 58)
                              ],
                            ),
                          ),
                          child: StreamBuilder(
                            builder: (BuildContext context,
                                    AsyncSnapshot<List<TarotNightMessage>>
                                        snapshot) =>
                                snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ListView.builder(
                                        reverse: true,
                                        controller: scrollController,
                                        itemBuilder: (context, index) {
                                          Message? nextMessage = index - 1 >= 0
                                              ? snapshot.data![index - 1]
                                              : null;
                                          Message? lastMessage =
                                              index + 1 < snapshot.data!.length
                                                  ? snapshot.data![index + 1]
                                                  : null;

                                          return snapshot.data != null
                                              ? TarotNightMessageBubble(
                                                  message:
                                                      snapshot.data![index],
                                                  roomId: widget.roomId,
                                                  isLastMsgSentBySameUser:
                                                      lastMessage == null
                                                          ? false
                                                          : lastMessage
                                                                  .senderId ==
                                                              snapshot
                                                                  .data![index]
                                                                  .senderId,
                                                  isNextMsgSentBySameUser:
                                                      nextMessage == null
                                                          ? false
                                                          : nextMessage
                                                                  .senderId ==
                                                              snapshot
                                                                  .data![index]
                                                                  .senderId,
                                                )
                                              : null;
                                        },
                                        itemCount: snapshot.data?.length,
                                      ),
                            stream: data.messageStream,
                          ),
                        ),
                        TarotNightAnnouncement(roomInfo: data.roomInfo)
                      ],
                    )),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 26, 0, 58),
                      ),
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 35.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 255, 255, 255)
                                            .withOpacity(0.15),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24)),
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
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .chat_room_message_enter,
                                          hintStyle: TextStyle(
                                              color: const Color.fromARGB(
                                                      255, 255, 255, 255)
                                                  .withOpacity(0.5),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  8, 12, 8, 12),
                                          border: const OutlineInputBorder(
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
                                          color: Colors.white.withOpacity(0.5),
                                          icon: const FaIcon(
                                              FontAwesomeIcons.solidPaperPlane),
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
                                              ref
                                                  .read(provider.notifier)
                                                  .markAsRead();

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
          size: 20,
        ),
        menuChildren: <ChatMenuEntry>[
          ChatMenuEntry(
            label: Text(
              AppLocalizations.of(context)!.common_room_info,
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              context.push(
                  '${TarotNightRoomView.routeName}/${TarotNightRoomInfoView.routeName}',
                  extra: chatRoomInfo);
            },
          ),
          ChatMenuEntry(
            label: Text(
              AppLocalizations.of(context)!.common_room_member,
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              context.push(
                  '${TarotNightRoomView.routeName}/${MembersView.routeName}',
                  extra: chatRoomInfo.id);
            },
          ),
        ],
      ),
    ];
    return result;
  }
}
