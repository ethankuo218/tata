import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/providers/pages/chat_room_info_view_provider.dart';
import 'package:tata/src/ui/pages/home/widgets/create_chat_room_bottom_sheet.dart';
import 'package:tata/src/utils/tarot.dart';

class ChatRoomInfoView extends ConsumerWidget {
  const ChatRoomInfoView({super.key, required this.chatRoomId});

  final String chatRoomId;

  static const String routeName = 'room-info';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final ChatRoomInfoViewProvider provider =
        chatRoomInfoViewProvider(roomId: chatRoomId);

    return ref.watch(provider).when(
        data: (chatRoomInfo) => Scaffold(
              appBar: AppBar(
                title: const Text('Room Info'),
              ),
              body: Container(
                height: screenHeight,
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 7, 9, 47)),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height: screenHeight * 0.3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(Tarot.getTarotCardImage(
                                    chatRoomInfo.backgroundImage!)),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              )),
                              child: Container(
                                  decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.black.withOpacity(0.6),
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.0),
                                  ],
                                ),
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10),
                                    bottom: Radius.zero),
                              ))),
                          Container(
                            height: screenHeight * 0.3,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                  bottom: Radius.zero),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(chatRoomInfo.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color:
                                        const Color.fromARGB(255, 255, 228, 85)
                                            .withOpacity(0.8)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                    ChatRoomCategory.toText(
                                        chatRoomInfo.category),
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 228, 85),
                                        fontSize: 16)),
                              ),
                            ),
                            if (chatRoomInfo.hostId ==
                                FirebaseAuth.instance.currentUser!.uid)
                              IconButton(
                                  color: Colors.white,
                                  iconSize: 16,
                                  padding: EdgeInsets.zero,
                                  onPressed: () => {
                                        showCreateChatRoomBottomSheet(
                                            mode: CreateChatRoomBottomSheetMode
                                                .edit,
                                            roomInfo: chatRoomInfo,
                                            context, onClosed: (_) {
                                          if (_ == null) {
                                            return;
                                          }
                                          ref
                                              .read(provider.notifier)
                                              .editChatRoomInfo(
                                                  title: _['title'],
                                                  description: _['description'],
                                                  category: _['category'],
                                                  limit: _['limit']);
                                        })
                                      },
                                  icon: const FaIcon(
                                      FontAwesomeIcons.penToSquare))
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text('Description',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                          height: screenHeight * 0.18,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Scrollbar(
                              child: SingleChildScrollView(
                            child: Text(chatRoomInfo.description,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          )))
                    ],
                  ),
                ),
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())));
  }
}
