import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/providers/pages/chat_room_info_view_provider.dart';
import 'package:tata/src/utils/tarot.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatRoomInfoView extends ConsumerWidget {
  const ChatRoomInfoView({super.key, required this.chatRoomId});

  final String chatRoomId;

  static const String routeName = 'room-info';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChatRoomInfoViewProvider provider =
        chatRoomInfoViewProvider(roomId: chatRoomId);

    return ref.watch(provider).when(
        data: (chatRoomInfo) => Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 12, 13, 32),
                title: const Text('Room Info'),
              ),
              body: Scaffold(
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 12, 13, 32),
                    Color.fromARGB(255, 26, 0, 58)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Tarot.getTarotCardImage(
                                  chatRoomInfo.backgroundImage!)),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                            border: GradientBoxBorder(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color.fromARGB(255, 241, 189, 88)
                                        .withOpacity(0.8),
                                    const Color.fromARGB(255, 227, 216, 157)
                                        .withOpacity(0.2),
                                    const Color.fromARGB(255, 241, 189, 88)
                                        .withOpacity(0.8),
                                    const Color.fromARGB(255, 227, 216, 157)
                                        .withOpacity(0.2),
                                  ]),
                              width: 2,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 80),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color.fromARGB(255, 12, 13, 32)
                                      .withOpacity(0),
                                  const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.8),
                                ],
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 32,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 244, 185),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ChatRoomCategory.toText(
                                          context, chatRoomInfo.category),
                                      style: const TextStyle(
                                          height: 1.1,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 12, 13, 32)),
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.person,
                                            color: Color.fromARGB(
                                                255, 255, 244, 185)),
                                        const SizedBox(width: 4),
                                        Text(
                                            chatRoomInfo.memberCount.toString(),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 244, 185),
                                                fontSize: 14)),
                                      ],
                                    ))
                              ],
                            ),
                          )),
                      const SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Opacity(
                                      opacity: 0.6,
                                      child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 255, 244, 185),
                                              BlendMode.srcIn),
                                          width: 20,
                                          height: 24)),
                                  Opacity(
                                      opacity: 0.4,
                                      child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 255, 244, 185),
                                              BlendMode.srcIn),
                                          width: 16,
                                          height: 16)),
                                  Opacity(
                                      opacity: 0.2,
                                      child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 255, 244, 185),
                                              BlendMode.srcIn),
                                          width: 12,
                                          height: 12)),
                                  Opacity(
                                      opacity: 0.2,
                                      child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 255, 244, 185),
                                              BlendMode.srcIn),
                                          width: 12,
                                          height: 12)),
                                  Opacity(
                                      opacity: 0.4,
                                      child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 255, 244, 185),
                                              BlendMode.srcIn),
                                          width: 16,
                                          height: 16)),
                                  Opacity(
                                      opacity: 0.6,
                                      child: SvgPicture.asset(
                                          'assets/images/star_4.svg',
                                          colorFilter: const ColorFilter.mode(
                                              Color.fromARGB(
                                                  255, 255, 244, 185),
                                              BlendMode.srcIn),
                                          width: 20,
                                          height: 24))
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('- ${chatRoomInfo.title} -',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    '- ${AppLocalizations.of(context)!.chat_room_room_info_description} -',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                                height: 100,
                                child: Scrollbar(
                                    child: SingleChildScrollView(
                                  child: Text(chatRoomInfo.description,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())));
  }
}
