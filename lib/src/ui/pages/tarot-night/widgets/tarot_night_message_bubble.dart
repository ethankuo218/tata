import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_night_message.dart';
import 'package:tata/src/utils/avatar.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/test_result_view.dart';

class TarotNightMessageBubble extends StatelessWidget {
  final TarotNightMessage message;
  final bool isLastMsgSentBySameUser;
  final bool isNextMsgSentBySameUser;
  final String roomId;

  const TarotNightMessageBubble(
      {super.key,
      required this.message,
      this.roomId = '',
      required this.isLastMsgSentBySameUser,
      required this.isNextMsgSentBySameUser});

  @override
  Widget build(BuildContext context) {
    final bool isSystemMessage = message.type == TarotNightMessageType.system;
    final bool isSentByMe =
        message.senderId == FirebaseAuth.instance.currentUser!.uid;

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
          if (!isSystemMessage && isNextMsgSentBySameUser)
            const SizedBox(width: 28),
          if (!isSystemMessage && !isSentByMe && !isNextMsgSentBySameUser)
            CircleAvatar(
              radius: 14,
              backgroundImage:
                  AssetImage(Avatar.getAvatarImage(message.avatar)),
            ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSystemMessage && !isSentByMe && !isLastMsgSentBySameUser)
                Text(
                  message.name,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              if (!isSystemMessage && !isSentByMe && !isLastMsgSentBySameUser)
                const SizedBox(height: 8),
              message.type == TarotNightMessageType.normal
                  ? Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
                        message.content,
                        style: TextStyle(
                            color: isSystemMessage
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : isSentByMe
                                    ? const Color.fromARGB(255, 12, 13, 32)
                                    : const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  : Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSystemMessage
                            ? Colors.grey.withOpacity(0.3)
                            : isSentByMe
                                ? const Color.fromARGB(255, 241, 198, 255)
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
                      child: Column(
                        children: [
                          if (message.type == TarotNightMessageType.answer)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/star_3.svg',
                                  width: 16,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(
                                      Color.fromARGB(255, 223, 130, 255),
                                      BlendMode.srcIn),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  message.role,
                                  style: const TextStyle(
                                      height: 1.125,
                                      color: Color.fromARGB(255, 223, 130, 255),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(width: 4),
                                SvgPicture.asset(
                                  'assets/images/star_3.svg',
                                  width: 16,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(
                                      Color.fromARGB(255, 223, 130, 255),
                                      BlendMode.srcIn),
                                ),
                              ],
                            ),
                          Text(
                            message.content,
                            style: TextStyle(
                                color: isSentByMe
                                    ? const Color.fromARGB(255, 12, 13, 32)
                                    : const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          if (message.type == TarotNightMessageType.testResult)
                            TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.resolveWith(
                                        (state) => const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16)),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (state) => const Color.fromARGB(
                                                255, 223, 130, 255))),
                                onPressed: () {
                                  context.push(
                                      TarotNightTestResultView.routeName,
                                      extra: roomId);
                                },
                                child: const Text('查看測驗結果',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 12, 13, 32),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))),
                        ],
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
