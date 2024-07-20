import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/services/snackbar_service.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/custom_context_menu_item.dart';
import 'package:tata/src/utils/avatar.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

    return isSentByMe
        ? Padding(
            padding: EdgeInsets.fromLTRB(16, isLastMsgSentBySameUser ? 2 : 8,
                16, isNextMsgSentBySameUser ? 2 : 8),
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
                    if (!isSystemMessage &&
                        !isSentByMe &&
                        !isLastMsgSentBySameUser)
                      Text(
                        chatMessage.name,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    if (!isSystemMessage &&
                        !isSentByMe &&
                        !isLastMsgSentBySameUser)
                      const SizedBox(height: 8),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSystemMessage
                            ? Colors.grey.withOpacity(0.3)
                            : isSentByMe
                                ? const Color.fromARGB(255, 255, 244, 185)
                                : const Color.fromARGB(255, 255, 244, 185)
                                    .withOpacity(0.2),
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
                        chatMessage.content,
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
          )
        : ContextMenuRegion(
            contextMenu: ContextMenu(
                boxDecoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 13, 32),
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 244, 185),
                      width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                entries: [
                  CustomContextMenuItem(
                    label: '檢舉',
                    textColor: Colors.red,
                    onSelected: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 12, 13, 32),
                              title: const Text(
                                "這則留言讓您感到冒犯或不適嗎？",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 223, 130, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 223, 130, 255),
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              children: <Widget>[
                                const Text(
                                  'TATA 致力於創造一個友善的匿名聊天環境，任何不當行為都是不被允許的。我們將會立即盤查並處理您的檢舉。',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: SimpleDialogOption(
                                          onPressed: () {
                                            context.pop(false);
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 12, 13, 32),
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 223, 130, 255),
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Text(
                                                '取消',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 223, 130, 255),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SimpleDialogOption(
                                          onPressed: () {
                                            context.pop(true);
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 223, 130, 255),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Text(
                                                '確定',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 12, 13, 32),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                        ),
                                      ),
                                    ])
                              ],
                            );
                          }).then((value) {
                        if (value == true) {
                          launchUrlString('mailto:support@tatarot.app').then(
                              (value) => SnackbarService().showSnackBar(
                                  context: context,
                                  message: '檢舉已送出，我們將會盡快處理。'));
                        }
                      });
                    },
                  ),
                ]),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, isLastMsgSentBySameUser ? 2 : 8,
                  16, isNextMsgSentBySameUser ? 2 : 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: isSystemMessage
                    ? MainAxisAlignment.center
                    : isSentByMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  if (isNextMsgSentBySameUser) const SizedBox(width: 28),
                  if (!isSystemMessage &&
                      !isSentByMe &&
                      !isNextMsgSentBySameUser)
                    CircleAvatar(
                      radius: 14,
                      backgroundImage:
                          AssetImage(Avatar.getAvatarImage(chatMessage.avatar)),
                    ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isSystemMessage &&
                          !isSentByMe &&
                          !isLastMsgSentBySameUser)
                        Text(
                          chatMessage.name,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      if (!isSystemMessage &&
                          !isSentByMe &&
                          !isLastMsgSentBySameUser)
                        const SizedBox(height: 8),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSystemMessage
                              ? Colors.grey.withOpacity(0.3)
                              : isSentByMe
                                  ? const Color.fromARGB(255, 255, 244, 185)
                                  : const Color.fromARGB(255, 255, 244, 185)
                                      .withOpacity(0.2),
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
                          chatMessage.content,
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
            ));
  }
}
