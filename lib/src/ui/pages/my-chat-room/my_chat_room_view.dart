import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/providers/my_chat_room_list_provider.dart';
import 'package:tata/src/ui/shared/pages/chat-room/chat_room_view.dart';
import 'package:tata/src/core/models/route_argument.dart';
import 'package:tata/src/ui/pages/my-chat-room/widgets/my_chat_room_tile.dart';

class MyChatRoomView extends ConsumerStatefulWidget {
  const MyChatRoomView({super.key});

  static const routeName = '/my-chat-room';

  @override
  ConsumerState<MyChatRoomView> createState() {
    return _MyChatRoomViewState();
  }
}

class _MyChatRoomViewState extends ConsumerState<MyChatRoomView> {
  late User user;
  late bool isLoading = false;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    final chatRoomList = ref.watch(myChatRoomListProvider);

    return switch (chatRoomList) {
      AsyncData(:final value) => Scaffold(
            body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                itemBuilder: (context, index) {
                  var chatRoomInfo = value[index];
                  return MyChatRoomTile(
                      userUid: user.uid,
                      chatRoomInfo: chatRoomInfo,
                      onTap: (String? otherUserUid) => context.push(
                          ChatRoomView.routeName,
                          extra: ChatRoomArgument(
                              chatRoomInfo: chatRoomInfo,
                              otherUserUid: otherUserUid)));
                },
                itemCount: value.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 15),
              ))
            ],
          ),
        )),
      AsyncError(:final error) => Text(error.toString()),
      _ => const CircularProgressIndicator()
    };
  }
}
