import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/models/app_user_info.dart';
import 'package:tata/src/services/user.service.dart';

class MyChatRoomTile extends StatefulWidget {
  final String userUid;
  final ChatRoom chatRoomInfo;
  final Function onTap;

  const MyChatRoomTile(
      {super.key,
      required this.userUid,
      required this.chatRoomInfo,
      required this.onTap});

  @override
  State<MyChatRoomTile> createState() => _MyChatRoomTileState();
}

class _MyChatRoomTileState extends State<MyChatRoomTile> {
  AppUserInfo? otherUserInfo;

  @override
  void initState() {
    super.initState();

    if (widget.chatRoomInfo.type == ChatRoomType.realtime) {
      final String otherUserUid = widget.chatRoomInfo.members
          .firstWhere((element) => element != widget.userUid);
      UserService().getUserInfo(otherUserUid).then((value) {
        setState(() {
          otherUserInfo = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isRealtimeChat =
        widget.chatRoomInfo.type == ChatRoomType.realtime;

    return GestureDetector(
        onTap: () => widget.onTap(otherUserInfo),
        child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 40, 40, 40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                          child: Image.asset('assets/avatars/the_magician.png',
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
                                      'assets/avatars/the_magician.png',
                                      fit: BoxFit.cover),
                                ),
                              ),
                            )
                          ],
                        ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isRealtimeChat
                            ? otherUserInfo?.name ?? ''
                            : widget.chatRoomInfo.title,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: screenWidth * 0.5,
                        height: 20,
                        child: Text(
                          widget.chatRoomInfo.latestMessage?.message ??
                              'Break the ice!',
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  widget.chatRoomInfo.latestMessage != null
                      ? Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getDisplayTime(widget
                                        .chatRoomInfo.latestMessage?.timestamp),
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 15),
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
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            )));
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
