import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/core/models/message.dart';

class ChatMessageBubble extends StatelessWidget {
  final Message chatMessage;

  const ChatMessageBubble({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    final bool isSystemMessage = chatMessage.senderId == 'system';
    final bool isSentByMe =
        chatMessage.senderId == FirebaseAuth.instance.currentUser!.uid;
    final dateTime = chatMessage.timestamp.toDate();
    final time =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isSystemMessage
            ? MainAxisAlignment.center
            : isSentByMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          Column(
            children: [
              if (!isSystemMessage)
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              const SizedBox(height: 5),
            ],
          ),
          const SizedBox(width: 5),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: isSystemMessage
                  ? Colors.grey.withOpacity(0.3)
                  : isSentByMe
                      ? Colors.purple
                      : const Color.fromARGB(179, 45, 45, 45),
              borderRadius: isSystemMessage
                  ? const BorderRadius.all(Radius.circular(15))
                  : isSentByMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
            ),
            child: Text(
              chatMessage.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
