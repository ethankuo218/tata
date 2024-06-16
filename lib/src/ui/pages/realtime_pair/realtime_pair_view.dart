import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/core/providers/pages/realtime_pair_view_provider.dart';
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
      ref.read(realtimePairViewProvider.notifier).startPairing();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(realtimePairViewProvider).maybeWhen(initial: () {
      timerText = '00 : 00';
      timeCounter = 0;
      isPairing = false;
    }, loading: () {
      timeCounter++;
      isPairing = true;
    }, success: (String chatRoomId) {
      isPairing = false;

      showPairSuccessDialog(context, onClosed: (_) {
        ref.read(realtimePairViewProvider.notifier).reset();
        context.pushReplacement('/chat-room', extra: chatRoomId);
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
                          .read(realtimePairViewProvider.notifier)
                          .cancelPairing();
                    },
                    child: const Text('Cancel Pairing'))
                : ElevatedButton(
                    onPressed: () {
                      ref
                          .read(realtimePairViewProvider.notifier)
                          .startPairing();
                    },
                    child: const Text('Retry Pairing'))
          ],
        ),
      ),
    );
  }
}
