import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tata/src/core/providers/tarot_night_lobby_provider.dart';
import 'package:tata/src/core/services/snackbar_service.dart';
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

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
                  Stack(children: [
                    CarouselSlider(
                        items: introductionSliders,
                        carouselController: controller,
                        options: CarouselOptions(
                            height: screenHeight * 0.35,
                            autoPlay: false,
                            enlargeCenterPage: false,
                            aspectRatio: 2.0,
                            viewportFraction: 1.0,
                            padEnds: true,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                current = index;
                              });
                            })),
                    Container(
                      height: screenHeight * 0.35,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: introduction.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => controller.animateToPage(entry.key),
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
                  ]),
                  SizedBox(height: screenHeight * 0.06),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            showCreateTarotNightRoomBottomSheet(context,
                                onClosed: (_) {
                              if (_ == null) {
                                return;
                              }

                              ref
                                  .read(tarotNightLobbyProvider.notifier)
                                  .createTarotNightRoom(
                                      title: _["title"],
                                      description: _["description"],
                                      theme: _["theme"])
                                  .then((value) {
                                // navigate to tarot night chat room
                              }).catchError((e) {
                                SnackbarService().showSnackBar(
                                    context: context, message: e.toString());
                              });
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: screenHeight * 0.25,
                                width: screenWidth * 0.42,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 137, 118, 82)
                                            .withOpacity(0.3),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                                255, 137, 118, 82)
                                            .withOpacity(0.6),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  'assets/images/star.png',
                                  height: screenHeight * 0.25,
                                  width: screenWidth * 0.42,
                                ),
                              ),
                              Container(
                                  height: screenHeight * 0.25,
                                  width: screenWidth * 0.42,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                            255, 137, 118, 82)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10,
                                                            vertical: 5))),
                                            child: const Text('分享你的深夜故事',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'MedievalSharp')),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          )),
                      const Spacer(),
                      // TODO: Navigate to the room list page
                      Stack(
                        children: [
                          Container(
                            height: screenHeight * 0.25,
                            width: screenWidth * 0.42,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 137, 118, 82)
                                    .withOpacity(0.3),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 137, 118, 82)
                                            .withOpacity(0.6),
                                    width: 2),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(
                              'assets/images/star.png',
                              height: screenHeight * 0.25,
                              width: screenWidth * 0.42,
                            ),
                          ),
                          Container(
                              height: screenHeight * 0.25,
                              width: screenWidth * 0.42,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                        255, 137, 118, 82)),
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5))),
                                        child: const Text('給予回應',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'MedievalSharp')),
                                      )
                                    ],
                                  )
                                ],
                              )),
                          BackdropFilter(
                              blendMode: BlendMode.overlay,
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Container(
                                height: screenHeight * 0.25,
                                width: screenWidth * 0.42,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.0)),
                              ))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())));
  }
}

final List<int> introduction = [1, 2, 3, 4, 5];

final List<Widget> introductionSliders = introduction
    .map((item) => Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 137, 118, 82).withOpacity(0.3),
                  border: Border.all(
                      color: const Color.fromARGB(255, 137, 118, 82)
                          .withOpacity(0.6),
                      width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: const SingleChildScrollView(
                child: Text(
                  "Welcome to the Midnight Tarot! It's commonly believed that the veils between our conscious minds and our deeper truths grow thinner at night, making us more inclined to open up about our concerns. Here, we invite you to share whatever is weighing on your heart. In this collaborative and supportive space, we come together to help you reconnect with your innermost self. Join us in the gentle glow of the stars and let the tarot illuminate your path to self-discovery.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'MedievalSharp'),
                ),
              ),
            )
          ],
        ))
    .toList();
