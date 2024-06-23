import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/providers/shared/leave_chat_view_provider.dart';
import 'package:tata/src/ui/pages/home/home_view.dart';

class LeaveChatView extends ConsumerWidget {
  final String chatRoomId;
  const LeaveChatView({super.key, required this.chatRoomId});

  static const routeName = 'leave-chat';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LeaveChatViewProvider provider =
        leaveChatViewProvider(roomId: chatRoomId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Chat'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text('您確定要離開此聊天室嗎？ 離開即無法查看您聊天的所有紀錄',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 161, 161, 161)),
                          ),
                          onPressed: () {
                            ref.read(provider.notifier).leaveChat().then((_) =>
                                context.pushReplacement(HomeView.routeName));
                          },
                          child: const Text('Confirm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)))),
                  const SizedBox(width: 16),
                  Expanded(
                      flex: 1,
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          onPressed: () {
                            ref.read(provider.notifier).leaveChat().then((_) =>
                                context.pushReplacement(HomeView.routeName));
                          },
                          child: const Text('Confirm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
