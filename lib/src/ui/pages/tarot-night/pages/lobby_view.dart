import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/models/tarot_night_lobby_info.dart';
import 'package:tata/src/core/providers/pages/tarot-night/lobby_view_provider.dart';
import 'package:tata/src/core/services/snackbar_service.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_list_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_view.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/create_room_bottom_sheet.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/lobby_introduction_slider.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/tarot_night_walkthrough_dialog.dart';

class TarotNightLobbyView extends ConsumerWidget {
  const TarotNightLobbyView({super.key});

  static const routeName = '/tarot-night/lobby';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(tarotNightLobbyViewProvider).when(
        data: (lobbyInfo) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (lobbyInfo.markedAsNotShowAgain == false) {
              showTarotNightWalkthroughDialog(context,
                  onClosed: (markAsNotShowAgain) {
                if (markAsNotShowAgain == true) {
                  ref
                      .read(tarotNightLobbyViewProvider.notifier)
                      .markAsNotShowAgain();
                }
              });
            }
          });

          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 12, 13, 32),
                centerTitle: false,
                titleSpacing: 0,
              ),
              body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 12, 13, 32),
                        Color.fromARGB(255, 26, 0, 58)
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 72,
                            child: Column(
                              children: [
                                const SizedBox(height: 48),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/star_2.svg'),
                                    const SizedBox(width: 16),
                                    const Text(
                                      '占星塔羅夜',
                                      style: TextStyle(
                                          height: 1.0,
                                          color: Color.fromARGB(
                                              255, 223, 130, 255),
                                          fontSize: 24),
                                    ),
                                    const SizedBox(width: 16),
                                    SvgPicture.asset(
                                        'assets/images/star_2.svg'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 85,
                            top: 8,
                            child: Opacity(
                              opacity: 0.5,
                              child: SvgPicture.asset(
                                'assets/images/star_1.svg',
                                width: 42.32,
                                height: 42.32,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Expanded(
                          flex: 12, child: LobbyIntroductionSlider()),
                      const SizedBox(height: 28),
                      Expanded(
                          flex: 7,
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
                                              extra:
                                                  lobbyInfo.tarotNightRoomId);
                                          break;
                                        case ParticipantStatus.participant:
                                          break;
                                        case ParticipantStatus.notStarted:
                                          showCreateTarotNightRoomBottomSheet(
                                              context,
                                              mode:
                                                  CreateTarotNightRoomBottomSheetMode
                                                      .create, onClosed: (_) {
                                            if (_ == null) {
                                              return;
                                            }

                                            ref
                                                .read(
                                                    tarotNightLobbyViewProvider
                                                        .notifier)
                                                .createTarotNightRoom(
                                                    title: _["title"],
                                                    description:
                                                        _["description"],
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
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    255, 241, 198, 255)
                                                .withOpacity(0.1),
                                            border: GradientBoxBorder(
                                                gradient: LinearGradient(
                                                  colors: lobbyInfo
                                                              .participantStatus ==
                                                          ParticipantStatus
                                                              .participant
                                                      ? [
                                                          const Color.fromARGB(
                                                              240,
                                                              126,
                                                              126,
                                                              126),
                                                          const Color.fromARGB(
                                                              51,
                                                              241,
                                                              198,
                                                              255),
                                                          const Color.fromARGB(
                                                              240,
                                                              126,
                                                              126,
                                                              126),
                                                          const Color.fromARGB(
                                                              51,
                                                              241,
                                                              198,
                                                              255),
                                                        ]
                                                      : [
                                                          const Color.fromARGB(
                                                              240,
                                                              223,
                                                              130,
                                                              255),
                                                          const Color.fromARGB(
                                                              51,
                                                              241,
                                                              198,
                                                              255),
                                                          const Color.fromARGB(
                                                              240,
                                                              223,
                                                              130,
                                                              255),
                                                          const Color.fromARGB(
                                                              51,
                                                              241,
                                                              198,
                                                              255),
                                                        ],
                                                ),
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            Opacity(
                                              opacity: 0.6,
                                              child: SvgPicture.asset(
                                                  'assets/images/star_2.svg',
                                                  width: 30,
                                                  height: 30,
                                                  colorFilter: lobbyInfo
                                                              .participantStatus ==
                                                          ParticipantStatus
                                                              .participant
                                                      ? const ColorFilter.mode(
                                                          Color.fromARGB(255,
                                                              126, 126, 126),
                                                          BlendMode.srcIn)
                                                      : const ColorFilter.mode(
                                                          Color.fromARGB(255,
                                                              223, 130, 255),
                                                          BlendMode.srcIn)),
                                            ),
                                            const Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                      '創建一個聊天室，並描述你的心理困擾，尋求建議 !',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 12),
                                              decoration: BoxDecoration(
                                                  color: lobbyInfo
                                                              .participantStatus ==
                                                          ParticipantStatus
                                                              .participant
                                                      ? const Color.fromARGB(
                                                          255, 168, 168, 168)
                                                      : const Color.fromARGB(
                                                          255, 223, 130, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                  lobbyInfo.participantStatus ==
                                                          ParticipantStatus.host
                                                      ? '回到聊天室'
                                                      : '分享故事',
                                                  style: const TextStyle(
                                                    height: 1.0,
                                                    color: Color.fromARGB(
                                                        255, 12, 13, 32),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            )
                                          ],
                                        )),
                                  )),
                              const SizedBox(width: 16),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                      onTap: () {
                                        if (lobbyInfo.participantStatus ==
                                            ParticipantStatus.host) {
                                          return;
                                        }
                                        context.push(
                                            TarotNightRoomListView.routeName);
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                      255, 241, 198, 255)
                                                  .withOpacity(0.1),
                                              border: GradientBoxBorder(
                                                  gradient: LinearGradient(
                                                    colors: lobbyInfo
                                                                .participantStatus ==
                                                            ParticipantStatus
                                                                .host
                                                        ? [
                                                            const Color
                                                                .fromARGB(240,
                                                                126, 126, 126),
                                                            const Color
                                                                .fromARGB(51,
                                                                241, 198, 255),
                                                            const Color
                                                                .fromARGB(240,
                                                                126, 126, 126),
                                                            const Color
                                                                .fromARGB(51,
                                                                241, 198, 255),
                                                          ]
                                                        : [
                                                            const Color
                                                                .fromARGB(240,
                                                                223, 130, 255),
                                                            const Color
                                                                .fromARGB(51,
                                                                241, 198, 255),
                                                            const Color
                                                                .fromARGB(240,
                                                                223, 130, 255),
                                                            const Color
                                                                .fromARGB(51,
                                                                241, 198, 255),
                                                          ],
                                                  ),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              Opacity(
                                                opacity: 0.6,
                                                child: SvgPicture.asset(
                                                    'assets/images/star_2.svg',
                                                    width: 30,
                                                    height: 30,
                                                    colorFilter: lobbyInfo
                                                                .participantStatus ==
                                                            ParticipantStatus
                                                                .host
                                                        ? const ColorFilter.mode(
                                                            Color.fromARGB(255,
                                                                126, 126, 126),
                                                            BlendMode.srcIn)
                                                        : const ColorFilter.mode(
                                                            Color.fromARGB(255,
                                                                223, 130, 255),
                                                            BlendMode.srcIn)),
                                              ),
                                              const Expanded(
                                                  child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                      '選擇要解決的問題，進入聊天室幫助房主釐清困惑！',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16)),
                                                ),
                                              )),
                                              const SizedBox(height: 20),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 12),
                                                decoration: BoxDecoration(
                                                    color: lobbyInfo
                                                                .participantStatus ==
                                                            ParticipantStatus
                                                                .host
                                                        ? const Color.fromARGB(
                                                            255, 168, 168, 168)
                                                        : const Color.fromARGB(
                                                            255, 223, 130, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: const Text('解答疑惑',
                                                    style: TextStyle(
                                                        height: 1.0,
                                                        color: Color.fromARGB(
                                                            255, 12, 13, 32),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              )
                                            ],
                                          )))),
                            ],
                          )),
                      const SizedBox(height: 36),
                    ],
                  )));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())));
  }
}
