import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/ui/avatar.dart';

class ChatMessageBubble extends StatelessWidget {
  final Message chatMessage;
  final bool isLastMsgSentBySameUser;
  final bool isNextMsgSentBySameUser;

  const ChatMessageBubble(
      {super.key,
      required this.chatMessage,
      required this.isLastMsgSentBySameUser,
      required this.isNextMsgSentBySameUser});

  @override
  Widget build(BuildContext context) {
    final bool isSystemMessage = chatMessage.senderId == 'system';
    final bool isSentByMe =
        chatMessage.senderId == FirebaseAuth.instance.currentUser!.uid;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, isLastMsgSentBySameUser ? 2 : 8, 16,
          isNextMsgSentBySameUser ? 2 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isSystemMessage
            ? MainAxisAlignment.center
            : isSentByMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          if (isNextMsgSentBySameUser) const SizedBox(width: 28),
          if (!isSystemMessage && !isSentByMe && !isNextMsgSentBySameUser)
            CircleAvatar(
              radius: 14,
              backgroundImage:
                  AssetImage(Avatar.getAvatarImage(chatMessage.avatar)),
            ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSystemMessage && !isSentByMe && !isLastMsgSentBySameUser)
                Text(
                  chatMessage.name,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              if (!isSystemMessage && !isSentByMe && !isLastMsgSentBySameUser)
                const SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSystemMessage
                      ? Colors.grey.withOpacity(0.3)
                      : isSentByMe
                          ? const Color(0xfff1c6ff)
                          : const Color.fromARGB(51, 241, 198, 255),
                  borderRadius: isSystemMessage
                      ? const BorderRadius.all(Radius.circular(16))
                      : isSentByMe
                          ? BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: Radius.circular(
                                  isLastMsgSentBySameUser ? 4 : 16),
                              bottomLeft: const Radius.circular(16),
                              bottomRight: Radius.circular(
                                  isNextMsgSentBySameUser ? 4 : 16),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(
                                  isLastMsgSentBySameUser ? 4 : 16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(
                                  isNextMsgSentBySameUser ? 4 : 16),
                              bottomRight: const Radius.circular(16),
                            ),
                ),
                child: Text(
                  chatMessage.message,
                  style: TextStyle(
                      color: isSentByMe
                          ? const Color.fromARGB(255, 12, 13, 32)
                          : const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
