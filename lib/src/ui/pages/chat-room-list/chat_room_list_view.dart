import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/route_argument.dart';
import 'package:tata/src/core/providers/chat_room_list_provider.dart';
import 'package:tata/src/core/services/snackbar_service.dart';
import 'package:tata/src/ui/pages/chat-room-list/widgets/chat_room_tile.dart';
import 'package:tata/src/ui/pages/chat-room-list/dialogs/chat_room_detail_dialog.dart';
import 'package:tata/src/ui/shared/pages/chat_room_view.dart';
import 'package:tata/src/ui/shared/pages/create_chat_room_bottom_sheet.dart';

class ChatRoomListView extends ConsumerStatefulWidget {
  ChatRoomListView({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  ConsumerState<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends ConsumerState<ChatRoomListView> {
  @override
  void initState() {
    super.initState();
    widget._scrollController.addListener(() {
      if (mounted &&
          widget._scrollController.position.pixels ==
              widget._scrollController.position.maxScrollExtent) {
        ref.read(chatRoomListProvider.notifier).fetchNextList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = chatRoomListProvider;

    return ref.watch(provider).when(
          data: (chatRoomList) => Scaffold(
              body: RefreshIndicator(
            onRefresh: () => ref.read(provider.notifier).fetchFirstList(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showCreateChatRoomBottomSheet(context, onClosed: (_) {
                        if (_ == null) {
                          return;
                        }

                        ref
                            .read(provider.notifier)
                            .createChatRoom(
                                title: _["title"],
                                description: _["description"],
                                category: _["category"],
                                backgroundImage: _["backgroundImage"],
                                limit: _["limit"] ?? 2)
                            .then((value) {
                          context.push(ChatRoomView.routeName,
                              extra: ChatRoomArgument(chatRoomInfo: value));
                        }).catchError((e) {
                          SnackbarService().showSnackBar(
                              context: context, message: e.toString());
                        });
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 1),
                          borderRadius: BorderRadius.circular(18)),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView.separated(
                    controller: widget._scrollController,
                    itemBuilder: (context, index) {
                      var chatRoomInfo = chatRoomList[index];
                      return ChatRoomTile(
                          chatRoomInfo: chatRoomInfo,
                          onTap: () {
                            showChatRoomDetailDialog(context,
                                chatRoomInfo: chatRoomInfo, onClosed: (_) {
                              if (_ == null) {
                                return;
                              }

                              ref
                                  .read(provider.notifier)
                                  .joinChatRoom(chatRoomInfo)
                                  .then((value) {
                                context.push(ChatRoomView.routeName,
                                    extra: ChatRoomArgument(
                                        chatRoomInfo: chatRoomInfo));
                              }).catchError((e) {
                                SnackbarService().showSnackBar(
                                    context: context, message: e.toString());
                              });
                            });
                          });
                    },
                    itemCount: chatRoomList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 20),
                  ))
                ],
              ),
            ),
          )),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
              child: Text(error.toString(),
                  style: const TextStyle(color: Colors.red))),
        );
  }
}
