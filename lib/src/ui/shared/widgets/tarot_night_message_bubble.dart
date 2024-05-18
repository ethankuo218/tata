import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_night_message.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/test_result_view.dart';

class TarotNightMessageBubble extends StatelessWidget {
  final TarotNightMessage message;
  final String roomId;

  const TarotNightMessageBubble(
      {super.key, required this.message, this.roomId = ''});

  @override
  Widget build(BuildContext context) {
    final bool isSystemMessage = message.type == TarotNightMessageType.system;
    final bool isSentByMe =
        message.senderId == FirebaseAuth.instance.currentUser!.uid;
    final dateTime = message.timestamp.toDate();
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
          message.type == TarotNightMessageType.normal
              ? Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                    message.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              : Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          message.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (message.type == TarotNightMessageType.testResult)
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((state) =>
                                        const Color.fromARGB(
                                            255, 137, 118, 82))),
                            onPressed: () {
                              context.push(TarotNightTestResultView.routeName,
                                  extra: roomId);
                            },
                            child: const Text('查看測驗結果',
                                style: TextStyle(color: Colors.white))),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
