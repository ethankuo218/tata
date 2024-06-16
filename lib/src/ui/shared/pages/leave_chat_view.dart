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
    final double screenHeight = MediaQuery.of(context).size.height;
    final LeaveChatViewProvider provider =
        leaveChatViewProvider(roomId: chatRoomId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Chat'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.15, horizontal: 60.0),
          child: Column(
            children: [
              const Text('Do you want to leave this chat ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              SizedBox(height: screenHeight * 0.1),
              TextButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    ref.read(provider.notifier).leaveChat().then(
                        (_) => context.pushReplacement(HomeView.routeName));
                  },
                  child: const Text('Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
