import 'package:flutter/material.dart';

class ChatRoomAnnouncement extends StatefulWidget {
  final String announcement;

  const ChatRoomAnnouncement({super.key, required this.announcement});

  @override
  State<ChatRoomAnnouncement> createState() => _ChatRoomAnnouncementState();
}

class _ChatRoomAnnouncementState extends State<ChatRoomAnnouncement> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        height: isExpanded ? null : 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 37, 38, 55),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.campaign, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              widget.announcement,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
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
    );
  }
}
