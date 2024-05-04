import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/providers/my_chat_room_tile_provider.dart';

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
    final bool isRealtimeChat =
        roomInfo.fold((l) => l.type == ChatRoomType.realtime, (r) => false);
    final provider = myChatRoomTileProvider(
        chatRoomId: roomInfo.fold((l) => l.id, (r) => r.id));

    return ref.watch(provider).when(
        data: (otherUserInfo) => GestureDetector(
              onTap: () => onTap(),
              child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 40, 40, 40),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        isRealtimeChat
                            ? Container(
                                width: 50,
                                height: 50,
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
                              )
                            : Stack(
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
                                            color:
                                                Colors.white.withOpacity(0.8),
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
                                    width: 50,
                                    height: 50,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.8),
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
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isRealtimeChat
                                  ? otherUserInfo?.name ?? 'Unknown'
                                  : roomInfo.fold(
                                      (l) => l.title, (r) => r.title),
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 20,
                              child: Text(
                                roomInfo.fold((l) => l.latestMessage?.message,
                                        (r) => r.latestMessage?.message) ??
                                    'Break the ice!',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )),
                        roomInfo.fold((l) => l.latestMessage,
                                    (r) => r.latestMessage) !=
                                null
                            ? SizedBox(
                                width: 60,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      getDisplayTime(roomInfo.fold(
                                          (l) => l.latestMessage?.timestamp,
                                          (r) => r.latestMessage?.timestamp)),
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 10),
                                    // if (chatRoomInfo.unreadCount > 0)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
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
}
