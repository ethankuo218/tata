import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/providers/my_chat_room_view_provider.dart';
import 'package:tata/src/ui/shared/pages/chat_room_view.dart';
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
    return ref.watch(myChatRoomViewProvider).when(
          data: (list) => Scaffold(
              body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                  itemBuilder: (context, index) {
                    var chatRoomInfo = list[index];

                    return MyChatRoomTile(
                        userUid: user.uid,
                        roomInfo: chatRoomInfo,
                        onTap: () => context.push(ChatRoomView.routeName,
                            extra:
                                chatRoomInfo.fold((l) => l.id, (r) => r.id)));
                  },
                  itemCount: list.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 15),
                ))
              ],
            ),
          )),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        );
  }
}
