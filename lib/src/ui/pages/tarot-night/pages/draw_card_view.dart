import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/providers/pages/tarot-night/draw_card_view_provider.dart';
import 'package:tata/src/core/providers/pages/tarot-night/tarot_night_announcement_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/test_result_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TarotNightDrawCardView extends ConsumerWidget {
  const TarotNightDrawCardView(
      {super.key, required this.roomId, required this.question});

  final String roomId;
  final String question;

  static const routeName = '/tarot-night/draw-card';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(tarotNightDrawCardViewProvider).when(
          data: (card) => Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 12, 13, 32),
                leading: const SizedBox.shrink(),
              ),
              body: BottomBar(
                  offset: 30,
                  barColor: Colors.transparent,
                  child: SizedBox(
                      height: 48,
                      width: 160.5,
                      child: FittedBox(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor:
                                  const Color.fromARGB(255, 223, 130, 255),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12)),
                          onPressed: () {
                            ref
                                .read(tarotNightDrawCardViewProvider.notifier)
                                .drawCard(roomId: roomId, question: question)
                                .then((value) {
                              ref
                                  .read(tarotNightAnnouncementProvider.notifier)
                                  .loadTarotNightRoomInfo(roomId);

                              context.pushReplacement(
                                  TarotNightTestResultView.routeName,
                                  extra: roomId);
                            });
                          },
                          child: Text(
                              AppLocalizations.of(context)!
                                  .activity_chat_room_tarot_test_result,
                              style: const TextStyle(
                                  height: 1.0,
                                  color: Color.fromARGB(255, 12, 13, 32),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                      )),
                  body: (context, controller) => Column(
                        children: [
                          Expanded(
                            child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.fromLTRB(16, 20, 16, 36),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 12, 13, 32),
                                        Color.fromARGB(255, 26, 0, 58),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/star_5.svg',
                                        width: 40,
                                        height: 40,
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .draw_tarot_draw_card_title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          height: 7 / 5,
                                          color: Color.fromARGB(
                                              255, 241, 198, 255),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .draw_tarot_draw_card_description,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          height: 14 / 9,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      Stack(
                                        children: List.generate(
                                            10,
                                            (index) => Transform.rotate(
                                                angle: (pi / 180) *
                                                    (72 - index * 8),
                                                child: Opacity(
                                                    opacity: (index + 1) * 0.1,
                                                    child: Container(
                                                      width: 200,
                                                      height: 280,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: BoxDecoration(
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/card_back.png'),
                                                              fit: BoxFit.fill),
                                                          color:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  39, 30, 61),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          border:
                                                              GradientBoxBorder(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              223,
                                                                              130,
                                                                              255)
                                                                          .withOpacity(
                                                                              0.8),
                                                                      const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              241,
                                                                              198,
                                                                              255)
                                                                          .withOpacity(
                                                                              0.2),
                                                                      const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              223,
                                                                              130,
                                                                              255)
                                                                          .withOpacity(
                                                                              0.8),
                                                                      const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              241,
                                                                              198,
                                                                              255)
                                                                          .withOpacity(
                                                                              0.2),
                                                                    ],
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                  ),
                                                                  width: 2)),
                                                    )))),
                                      )
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ))),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error: $error'),
        );
  }
}
