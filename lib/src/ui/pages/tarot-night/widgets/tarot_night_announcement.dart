import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/draw_card_view.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/start_tarot_test_bottom_sheet.dart';

class TarotNightAnnouncement extends StatefulWidget {
  const TarotNightAnnouncement({super.key, required this.roomInfo});

  final TarotNightRoom roomInfo;

  @override
  State<TarotNightAnnouncement> createState() => _TarotNightAnnouncementState();
}

class _TarotNightAnnouncementState extends State<TarotNightAnnouncement> {
  late DateTime enableTestButtonTime =
      widget.roomInfo.createTime.toDate().add(const Duration(minutes: 30));
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
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const FaIcon(
              FontAwesomeIcons.clock,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(timerView,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            if (widget.roomInfo.hostId ==
                FirebaseAuth.instance.currentUser?.uid)
              TextButton(
                  onPressed: () {
                    // if (!isTestButtonEnabled) {
                    //   return;
                    // }
                    showStartTarotTestBottomSheet(context, onClosed: (_) {
                      if (_ == null) {
                        return;
                      }

                      context.push(TarotNightDrawCardView.routeName,
                          extra: {'roomId': widget.roomInfo.id, 'question': _});
                    });
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size.zero),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8)),
                      backgroundColor: isTestButtonEnabled
                          ? MaterialStateProperty.all(
                              const Color.fromARGB(255, 223, 130, 255))
                          : MaterialStateProperty.all(
                              const Color.fromARGB(255, 168, 168, 168))),
                  child: Text('開始測驗',
                      style: TextStyle(
                          color: isTestButtonEnabled
                              ? const Color.fromARGB(255, 12, 13, 32)
                              : const Color.fromARGB(255, 12, 13, 32)
                                  .withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
