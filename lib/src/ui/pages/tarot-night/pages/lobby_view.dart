import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_night_lobby_info.dart';
import 'package:tata/src/core/providers/tarot_night_lobby_provider.dart';
import 'package:tata/src/core/services/snackbar_service.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/tarot_night_room_view.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/create_room_bottom_sheet.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/lobby_introduction_slider.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/tarot_night_walkthrough_dialog.dart';
import 'package:tata/src/ui/shared/widgets/app_bar.dart';

class LobbyView extends ConsumerStatefulWidget {
  const LobbyView({super.key});

  static const routeName = '/tarot-night/lobby';

  @override
  ConsumerState<LobbyView> createState() => _LobbyViewState();
}

class _LobbyViewState extends ConsumerState<LobbyView> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(tarotNightLobbyProvider).when(
        data: (lobbyInfo) {
          print('Build LobbyView');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (lobbyInfo.markedAsNotShowAgain == false) {
              showTarotNightWalkthroughDialog(context,
                  onClosed: (markAsNotShowAgain) {
                if (markAsNotShowAgain == true) {
                  ref
                      .read(tarotNightLobbyProvider.notifier)
                      .markAsNotShowAgain();
                }
              });
            }
          });

          return Scaffold(
            appBar: const AppBarWidget(),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Center(
                      child: Text(
                        'Astrological Tarot Night',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'MedievalSharp'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Expanded(flex: 5, child: LobbyIntroductionSlider()),
                    const SizedBox(height: 40),
                    Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    switch (lobbyInfo.participantStatus) {
                                      case ParticipantStatus.host:
                                        context.push(
                                            TarotNightRoomView.routeName,
                                            extra: lobbyInfo.tarotNightRoomId);
                                        break;
                                      case ParticipantStatus.participant:
                                        break;
                                      case ParticipantStatus.notStarted:
                                        showCreateTarotNightRoomBottomSheet(
                                            context, onClosed: (_) {
                                          if (_ == null) {
                                            return;
                                          }

                                          ref
                                              .read(tarotNightLobbyProvider
                                                  .notifier)
                                              .createTarotNightRoom(
                                                  title: _["title"],
                                                  description: _["description"],
                                                  theme: _["theme"])
                                              .then((value) {
                                            context.push(
                                                TarotNightRoomView.routeName,
                                                extra: value.id);
                                          }).catchError((e) {
                                            SnackbarService().showSnackBar(
                                                context: context,
                                                message: e.toString());
                                          });
                                        });
                                        break;
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    255, 137, 118, 82)
                                                .withOpacity(0.3),
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                        255, 137, 118, 82)
                                                    .withOpacity(0.6),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Image.asset(
                                          'assets/images/star.png',
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  const Spacer(),
                                                  TextButton(
                                                    onPressed: () {},
                                                    style: ButtonStyle(
                                                        minimumSize:
                                                            MaterialStateProperty
                                                                .all(Size.zero),
                                                        backgroundColor:
                                                            MaterialStateProperty.all(
                                                                const Color.fromARGB(
                                                                    255,
                                                                    137,
                                                                    118,
                                                                    82)),
                                                        padding: MaterialStateProperty.all(
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5))),
                                                    child: Text(
                                                        lobbyInfo.participantStatus ==
                                                                ParticipantStatus
                                                                    .host
                                                            ? '回到聊天室'
                                                            : '分享你的深夜故事',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'MedievalSharp')),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                )),
                            const SizedBox(width: 20),
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                    onTap: () {
                                      // navigate to chat room list
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                      255, 137, 118, 82)
                                                  .withOpacity(0.3),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                          255, 137, 118, 82)
                                                      .withOpacity(0.6),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Image.asset(
                                            'assets/images/star.png',
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    const Spacer(),
                                                    TextButton(
                                                      onPressed: () {},
                                                      style: ButtonStyle(
                                                          minimumSize:
                                                              MaterialStateProperty.all(
                                                                  Size.zero),
                                                          backgroundColor:
                                                              MaterialStateProperty.all(
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      137,
                                                                      118,
                                                                      82)),
                                                          padding: MaterialStateProperty.all(
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5))),
                                                      child: const Text('給予回應',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'MedievalSharp')),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )),
                                        BackdropFilter(
                                            blendMode: BlendMode.overlay,
                                            filter: ImageFilter.blur(
                                                sigmaX: 1, sigmaY: 1),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.0)),
                                            ))
                                      ],
                                    ))),
                          ],
                        )),
                    const SizedBox(height: 100),
                  ],
                )),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())));
  }
}
