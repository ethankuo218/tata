import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/providers/pages/my_chat_room_tile_provider.dart';
import 'package:tata/src/utils/avatar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyChatRoomTile extends ConsumerWidget {
  final String userUid;
  final Either<ChatRoom, TarotNightRoom> roomInfo;
  final Function onTap;

  const MyChatRoomTile({
    super.key,
    required this.userUid,
    required this.roomInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bool isRealtimeChat =
    //     roomInfo.fold((l) => l.type == ChatRoomType.realtime, (r) => false);
    final provider = myChatRoomTileProvider(
        chatRoomId: roomInfo.fold((l) => l.id, (r) => r.id));

    return ref.watch(provider).when(
        data: (unReadMessageCount) => GestureDetector(
              onTap: () => onTap(),
              child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 244, 185)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.8),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Image.asset(
                                      Avatar.getAvatarImage(
                                          Avatar.getRandomAvatar()),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.8),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Image.asset(
                                      Avatar.getAvatarImage(
                                          Avatar.getRandomAvatar()),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  // isRealtimeChat
                                  //     ? otherUserInfo?.name ?? 'Unknown'
                                  //     :
                                  roomInfo.fold((l) => l.title, (r) => r.title),
                                  maxLines: 1,
                                  style: const TextStyle(
                                      height: 11 / 8,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )),
                                const SizedBox(width: 8),
                                roomInfo.fold((l) => l.latestMessage,
                                            (r) => r.latestMessage) !=
                                        null
                                    ? Text(
                                        getDisplayTime(roomInfo.fold(
                                            (l) => l.latestMessage?.timestamp,
                                            (r) => r.latestMessage?.timestamp)),
                                        style: TextStyle(
                                            height: 11 / 7,
                                            color: const Color.fromARGB(
                                                    255, 255, 244, 185)
                                                .withOpacity(0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  height: 22,
                                  child: Text(
                                    roomInfo.fold(
                                            (l) => l.latestMessage!.senderId ==
                                                    'system'
                                                ? getSystemMessage(context,
                                                    l.latestMessage!.content)
                                                : l.latestMessage?.content,
                                            (r) => r.latestMessage?.content) ??
                                        'Break the ice!',
                                    maxLines: 1,
                                    style: TextStyle(
                                        height: 11 / 7,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )),
                                if (unReadMessageCount > 0)
                                  const SizedBox(width: 8),
                                if (unReadMessageCount > 0)
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 195, 79),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        unReadMessageCount.toString(),
                                        style: const TextStyle(
                                            height: 1,
                                            color:
                                                Color.fromARGB(255, 12, 13, 32),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  )),
            ),
        loading: () => const SizedBox(),
        error: (error, stack) => const SizedBox());
  }

  String getDisplayTime(Timestamp? timestamp) {
    if (timestamp == null) {
      return '00:00';
    }

    final Timestamp today = Timestamp.now();
    final bool isToday = timestamp.toDate().day == today.toDate().day;
    final bool isYesterday = timestamp.toDate().day == today.toDate().day - 1;

    if (isYesterday) {
      return 'Yesterday';
    }

    return isToday
        ? '${timestamp.toDate().hour.toString().padLeft(2, '0')}:${timestamp.toDate().minute.toString().padLeft(2, '0')}'
        : '${timestamp.toDate().month.toString().padLeft(2, '0')}/${timestamp.toDate().day.toString().padLeft(2, '0')}';
  }

  String getSystemMessage(BuildContext context, String key) {
    List<String> keySplit = key.split(' ');
    key = keySplit[keySplit.length - 1];
    keySplit.removeAt(keySplit.length - 1);
    String name = keySplit.join(' ');

    switch (key) {
      case 'room_joined':
        return '$name ${AppLocalizations.of(context)!.chat_room_system_message_join_chat_room}';
      case 'room_created':
        return AppLocalizations.of(context)!.chat_room_system_message_welcome;
      case 'room_closed':
        return AppLocalizations.of(context)!.common_room_closed;
      case 'room_left':
        return '$name ${AppLocalizations.of(context)!.chat_room_system_message_member_leave}';
      default:
        return key;
    }
  }
}
