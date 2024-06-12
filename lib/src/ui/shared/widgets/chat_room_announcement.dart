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
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: isExpanded ? null : 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(25, 255, 255, 255),
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
