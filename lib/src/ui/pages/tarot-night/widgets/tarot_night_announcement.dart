import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/draw_card_view.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/start_tarot_test_dialog.dart';

class TarotNightAnnouncement extends StatefulWidget {
  const TarotNightAnnouncement({super.key, required this.createTime});

  final Timestamp createTime;

  @override
  State<TarotNightAnnouncement> createState() => _TarotNightAnnouncementState();
}

class _TarotNightAnnouncementState extends State<TarotNightAnnouncement> {
  late DateTime enableTestButtonTime =
      widget.createTime.toDate().add(const Duration(minutes: 30));
  late Timer timer;
  late String timerView = '--:--:--';
  late bool isTestButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // Create a timer that will run at 1 AM tomorrow
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = DateTime.now();
      final DateTime oneAmTomorrow =
          DateTime(now.year, now.month, now.day + 1, 1, 0);

      // Calculate the duration between now and 1 AM tomorrow
      // update timerView every second before the timer reaches 1 AM tomorrow
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final duration = oneAmTomorrow.difference(DateTime.now());
        if (duration.inSeconds <= 0) {
          timer.cancel();
          return;
        }

        final String hours =
            duration.inHours.remainder(24).toString().padLeft(2, '0');
        final String minutes =
            duration.inMinutes.remainder(60).toString().padLeft(2, '0');
        final String seconds =
            duration.inSeconds.remainder(60).toString().padLeft(2, '0');

        setState(() {
          timerView = '$hours:$minutes:$seconds';
          if (DateTime.now().isAfter(enableTestButtonTime)) {
            isTestButtonEnabled = true;
          }
        });
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 41, 41, 41),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.timer, color: Colors.white),
            const SizedBox(width: 10),
            Text(timerView, style: const TextStyle(color: Colors.white)),
            const Spacer(),
            TextButton(
                onPressed: () {
                  // if (!isTestButtonEnabled) {
                  //   return;
                  // }
                  showStartTarotTestDialog(context, onClosed: (_) {
                    if (_ == null) {
                      return;
                    }

                    // save question to firestore
                    // navigate to tarot test page
                    context.push(TarotNightDrawCardView.routeName);
                  });
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8)),
                    backgroundColor: isTestButtonEnabled
                        ? MaterialStateProperty.all(
                            const Color.fromARGB(255, 137, 118, 82))
                        : MaterialStateProperty.all(
                            const Color.fromARGB(255, 137, 118, 82)
                                .withOpacity(0.5))),
                child: Text('Start Test',
                    style: TextStyle(
                        color: isTestButtonEnabled
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
