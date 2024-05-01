import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_night_lobby_info.dart';
import 'package:tata/src/core/providers/tarot_night_lobby_provider.dart';
import 'package:tata/src/core/services/snackbar_service.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/tarot_night_room_view.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/create_room_bottom_sheet.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/tarot_night_walkthrough_dialog.dart';
import 'package:tata/src/ui/shared/widgets/app_bar.dart';

class LobbyView extends ConsumerStatefulWidget {
  const LobbyView({super.key});

  static const routeName = '/tarot-night/lobby';

  @override
  ConsumerState<LobbyView> createState() => _LobbyViewState();
}

class _LobbyViewState extends ConsumerState<LobbyView> {
  int current = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return ref.watch(tarotNightLobbyProvider).when(
        data: (lobbyInfo) {
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
                    Expanded(
                        flex: 5,
                        child: Stack(children: [
                          CarouselSlider(
                              items: introductionSliders,
                              carouselController: controller,
                              options: CarouselOptions(
                                  height: double.infinity,
                                  autoPlay: false,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1.0,
                                  padEnds: true,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      current = index;
                                    });
                                  })),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  introduction.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(
                                            current == entry.key ? 0.9 : 0.4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ])),
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

final List<int> introduction = [1, 2, 3];

final List<Widget> introductionSliders = <Widget>[
  LayoutBuilder(builder: (context, constraints) {
    return Stack(
      children: [
        Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 137, 118, 82).withOpacity(0.3),
              border: Border.all(
                  color:
                      const Color.fromARGB(255, 137, 118, 82).withOpacity(0.6),
                  width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: const SingleChildScrollView(
            child: Text(
              "深入探索心靈的迷宮，解開你的疑慮與困惑。在這個神秘的夜晚遊戲中，選擇成為提問者深挖內心之謎，或成為回答者以智慧為他人照亮前路。",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'MedievalSharp'),
            ),
          ),
        )
      ],
    );
  }),
  LayoutBuilder(builder: (context, constraints) {
    return Stack(
      children: [
        Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 137, 118, 82).withOpacity(0.3),
              border: Border.all(
                  color:
                      const Color.fromARGB(255, 137, 118, 82).withOpacity(0.6),
                  width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                Text("遊戲參與者選擇\n",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MedievalSharp')),
                Text(
                  "房主：\n當你感到心中有疑惑或困擾時，創建一個聊天室，並描述你的心理困擾，尋求來自其他參與者的見解與建議。\n\n參加者：\n選擇進入聊天室，抽取一張角色牌，每張角色牌將指引你完成特定的任務，幫助房主釐清困惑。",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'MedievalSharp'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }),
  LayoutBuilder(builder: (context, constraints) {
    return Stack(
      children: [
        Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 137, 118, 82).withOpacity(0.3),
              border: Border.all(
                  color:
                      const Color.fromARGB(255, 137, 118, 82).withOpacity(0.6),
                  width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                Text("遊戲流程與活動時間\n",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MedievalSharp')),
                Text(
                  "• 活動時間：每晚 11:00 至 01:00。\n• 房主在活動開始 30 分鐘後可以進行塔羅牌測驗，輸入想問的問題並抽取一張塔羅牌。\n• 房主將抽出的塔羅牌分享至聊天室。\n• 參加者根據塔羅牌解析提供答案，完成其角色任務。",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'MedievalSharp'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  })
];
