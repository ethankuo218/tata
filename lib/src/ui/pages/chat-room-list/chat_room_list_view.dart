import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/providers/pages/chat_room_list_view_provider.dart';
import 'package:tata/src/core/services/snackbar_service.dart';
import 'package:tata/src/ui/pages/chat-room-list/widgets/chat_room_tile.dart';
import 'package:tata/src/ui/pages/chat-room-list/dialogs/chat_room_detail_dialog.dart';
import 'package:tata/src/ui/pages/chat-room/chat_room_view.dart';

class ChatRoomListView extends ConsumerStatefulWidget {
  ChatRoomListView({super.key});

  final ScrollController _scrollController = ScrollController();

  static const List<ChatRoomCategory> categoryList = [
    ChatRoomCategory.all,
    ChatRoomCategory.romance,
    ChatRoomCategory.work,
    ChatRoomCategory.interest,
    ChatRoomCategory.sport,
    ChatRoomCategory.family,
    ChatRoomCategory.friend,
    ChatRoomCategory.chitchat,
    ChatRoomCategory.school
  ];

  @override
  ConsumerState<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends ConsumerState<ChatRoomListView>
    with SingleTickerProviderStateMixin {
  final provider = chatRoomListViewProvider;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: ChatRoomListView.categoryList.length, vsync: this);

    widget._scrollController.addListener(() {
      if (mounted &&
          widget._scrollController.position.pixels ==
              widget._scrollController.position.maxScrollExtent) {
        ref.read(chatRoomListViewProvider.notifier).fetchNextList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(provider).when(
          data: (chatRoomListMap) {
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromARGB(255, 12, 13, 32),
                    Color.fromARGB(255, 26, 0, 58)
                  ])),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 244, 185)
                                  .withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0))),
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            labelColor: const Color.fromARGB(255, 255, 195, 79),
                            unselectedLabelColor: Colors.white,
                            indicatorColor:
                                const Color.fromARGB(255, 255, 195, 79),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: const TextStyle(
                                height: 1.5,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            dividerColor: Colors.transparent,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            tabs: ChatRoomListView.categoryList
                                .map((e) => ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxHeight: 32,
                                        minHeight: 32,
                                        minWidth: 56),
                                    child:
                                        Tab(text: ChatRoomCategory.toText(e))))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.all] ?? []),
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.romance] ?? []),
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.work] ?? []),
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.interest] ?? []),
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.sport] ?? []),
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.family] ?? []),
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.friend] ?? []),
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.chitchat] ?? []),
                      _buildListView(
                          chatRoomListMap[ChatRoomCategory.school] ?? []),
                    ],
                  ))
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
              child: Text(error.toString(),
                  style: const TextStyle(color: Colors.red))),
        );
  }

  Widget _buildListView(List<ChatRoom> chatRoomList) {
    return RefreshIndicator(
        onRefresh: ref.read(provider.notifier).fetchFirstList,
        child: ListView.separated(
          controller: widget._scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (chatRoomList.isEmpty) {
              return const Text(
                'No chat room found',
                style: TextStyle(color: Colors.white),
              );
            }

            var chatRoomInfo = chatRoomList[index];
            return ChatRoomTile(
                chatRoomInfo: chatRoomInfo,
                onTap: () {
                  showChatRoomDetailDialog(context, chatRoomInfo: chatRoomInfo,
                      onClosed: (_) {
                    if (_ == null) {
                      return;
                    }

                    ref
                        .read(provider.notifier)
                        .joinChatRoom(chatRoomInfo.id)
                        .then((value) {
                      context.push(ChatRoomView.routeName,
                          extra: chatRoomInfo.id);
                    }).catchError((e) {
                      SnackbarService().showSnackBar(
                          context: context, message: e.toString());
                    });
                  });
                });
          },
          itemCount: chatRoomList.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 16),
        ));
  }
}
