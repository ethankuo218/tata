import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/chat-room-list/dialogs/chat_room_detail_dialog.dart';
import 'package:tata/src/chat-room/chat_room_view.dart';
import 'package:tata/src/core/tarot.dart';
import 'package:tata/src/create-chat-room/create_chat_room_bottom_sheet.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/models/route_argument.dart';
import 'package:tata/src/services/chat.service.dart';
import 'package:tata/src/services/snackbar.service.dart';

class ChatRoomListController {
  // late BuildContext context;
  final Stream<List<ChatRoom>> lobbyListStream =
      ChatService().getLobbyChatRoomList();

  // void init(BuildContext context) {
  //   this.context = context;
  // }

  void createChatRoom(BuildContext context) {
    showCreateChatRoomBottomSheet(context, onClosed: (_) {
      if (_ == null) {
        return;
      }
      ChatService().createChatRoom(
          category: _["category"],
          title: _["title"],
          description: _["description"],
          backgroundImage: Tarot.getRandomCard(),
          limit: _["limit"] ?? 2);
    });
  }

  void onChatRoomTilePressed(BuildContext context, ChatRoom chatRoomInfo) {
    showChatRoomDetailDialog(context, chatRoomInfo: chatRoomInfo,
        onClosed: (_) {
      if (_ == null) {
        return;
      }

      ChatService().joinChatRoom(chatRoomInfo).then((value) {
        context.push(ChatRoomView.routeName,
            extra: ChatRoomArgument(chatRoomInfo: chatRoomInfo));
      }).onError<Exception>((error, stackTrace) {
        SnackbarService()
            .showSnackBar(context: context, message: error.toString());
      }).catchError((e) {
        SnackbarService().showSnackBar(
            context: context,
            message: 'Unknown error: Please contact the support team');
      });
    });
  }
}
