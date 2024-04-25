import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:tata/src/core/providers/realtime_pair_provider.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/core/models/route_argument.dart';
import 'package:tata/src/ui/pages/realtime_pair/dialogs/pair_success_dialog.dart';

class RealtimePairView extends ConsumerStatefulWidget {
  const RealtimePairView({super.key});

  static const routeName = '/realtime-pair';

  @override
  ConsumerState<RealtimePairView> createState() => _RealtimePairPageState();
}

class _RealtimePairPageState extends ConsumerState<RealtimePairView> {
  bool isPairing = false;

  late Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {});
  late int timeCounter = 0;
  String timerText = '00 : 00';

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isPairing == true) {
        setState(() {
          timerText =
              '${(timeCounter / 60).floor().toString().padLeft(2, '0')} : ${(timeCounter % 60).toString().padLeft(2, '0')}';
        });
      }
    });

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(realtimePairStateProvider.notifier).startPairing();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(realtimePairStateProvider).maybeWhen(initial: () {
      timerText = '00 : 00';
      timeCounter = 0;
      isPairing = false;
    }, loading: () {
      timeCounter++;
      isPairing = true;
    }, success: (ChatRoom chatRoomInfo) {
      isPairing = false;

      String userUid = FirebaseAuth.instance.currentUser!.uid;
      String otherUserUid = chatRoomInfo.members[0] == userUid
          ? chatRoomInfo.members[1]
          : chatRoomInfo.members[0];

      showPairSuccessDialog(context, onClosed: (_) {
        ref.read(realtimePairStateProvider.notifier).reset();
        context.pushReplacement('/chat-room',
            extra: ChatRoomArgument(
                chatRoomInfo: chatRoomInfo, otherUserUid: otherUserUid));
      });
    }, failed: (String error) {
      isPairing = false;
    }, orElse: () {
      isPairing = false;
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            isPairing == true
                ? Column(
                    children: [
                      const AspectRatio(
                        aspectRatio: 1,
                        child: RiveAnimation.asset(
                          'assets/rive-assets/hourglass.riv',
                          fit: BoxFit.cover,
                          animations: ['loading'],
                        ),
                      ),
                      Text(timerText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 40)),
                    ],
                  )
                : const Text('Pairing Failed',
                    style: TextStyle(color: Colors.white, fontSize: 40)),
            const SizedBox(height: 20),
            isPairing == true
                ? ElevatedButton(
                    onPressed: () {
                      ref
                          .read(realtimePairStateProvider.notifier)
                          .cancelPairing();
                    },
                    child: const Text('Cancel Pairing'))
                : ElevatedButton(
                    onPressed: () {
                      ref
                          .read(realtimePairStateProvider.notifier)
                          .startPairing();
                    },
                    child: const Text('Retry Pairing'))
          ],
        ),
      ),
    );
  }
}
