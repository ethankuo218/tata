import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_card.dart';
import 'package:tata/src/core/providers/pages/tarot-night/test_result_view_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/quest_bottom_sheet.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/test_result_expandable_panel.dart';

class TarotNightTestResultView extends ConsumerStatefulWidget {
  const TarotNightTestResultView({super.key, required this.roomId});

  final String roomId;

  static const routeName = '/tarot-night/test-result';

  @override
  ConsumerState<TarotNightTestResultView> createState() =>
      _TarotNightTestResultViewState();
}

class _TarotNightTestResultViewState
    extends ConsumerState<TarotNightTestResultView> {
  late List<DescriptionItem> _data;

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(tarotNightTestResultViewProvider(roomId: widget.roomId))
        .when(
          data: (roomInfo) {
            final TarotCard card = ref
                .read(tarotNightTestResultViewProvider(roomId: widget.roomId)
                    .notifier)
                .getCard();

            _data = [
              DescriptionItem(
                title: '工作',
                description: card.workDescription,
              ),
              DescriptionItem(
                title: '感情',
                description: card.relationDescription,
              ),
              DescriptionItem(
                title: '友情',
                description: card.friendDescription,
              ),
              DescriptionItem(
                title: '家庭',
                description: card.familyDescription,
              ),
            ];

            return Scaffold(
                appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 12, 13, 32),
                    automaticallyImplyLeading: false,
                    toolbarHeight: 0,
                    titleSpacing: 0,
                    centerTitle: false),
                body: BottomBar(
                    offset: 30,
                    barColor: Colors.transparent,
                    child: roomInfo.hostId !=
                            FirebaseAuth.instance.currentUser!.uid
                        ? TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10)),
                            onPressed: () {
                              ref
                                  .read(tarotNightTestResultViewProvider(
                                          roomId: widget.roomId)
                                      .notifier)
                                  .getQuest()
                                  .then((quest) {
                                showQuestBottomSheet(context, quest: quest,
                                    onClosed: (answer) {
                                  if (answer == null) {
                                    return;
                                  }
                                  ref
                                      .read(tarotNightTestResultViewProvider(
                                              roomId: widget.roomId)
                                          .notifier)
                                      .submitTaskAnswer(answer)
                                      .then((value) {
                                    context.pop();
                                  });
                                });
                              });
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('去解任務',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 137, 118, 82),
                                        fontSize: 20)),
                                SizedBox(width: 10),
                                FaIcon(FontAwesomeIcons.arrowRight,
                                    color: Color.fromARGB(255, 137, 118, 82),
                                    size: 18)
                              ],
                            ),
                          )
                        : const SizedBox(),
                    body: (context, controller) => SingleChildScrollView(
                            child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                Color.fromARGB(255, 12, 13, 32),
                                Color.fromARGB(255, 26, 0, 58),
                              ])),
                          child: Column(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 32, 20, 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/star_4.svg',
                                        width: 20, height: 20),
                                    const SizedBox(width: 10),
                                    const Text('這是你的測驗解析',
                                        style: TextStyle(
                                            height: 1.0,
                                            color: Color.fromARGB(
                                                255, 223, 130, 255),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(width: 10),
                                    SvgPicture.asset('assets/images/star_4.svg',
                                        width: 20, height: 20),
                                  ],
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                            height: 400,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 241, 198, 255),
                                                    width: 3),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                child: Image.asset(card.image,
                                                    fit: BoxFit.cover))),
                                        Container(
                                            height: 400,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 241, 198, 255),
                                                    width: 3),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  const Spacer(),
                                                  Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  stops: [
                                                                    0.1253,
                                                                    1.036
                                                                  ],
                                                                  colors: [
                                                                    Color
                                                                        .fromARGB(
                                                                            0,
                                                                            12,
                                                                            13,
                                                                            32),
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            12,
                                                                            13,
                                                                            32),
                                                                  ]),
                                                              borderRadius: BorderRadius.vertical(
                                                                  bottom: Radius
                                                                      .circular(
                                                                          7))),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 12,
                                                          horizontal: 8),
                                                      child: Row(children: [
                                                        const Spacer(),
                                                        IconButton(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            color: Colors.white,
                                                            onPressed: () {
                                                              print('Share');
                                                            },
                                                            icon: const Icon(
                                                                Icons.share)),
                                                        IconButton(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            color: Colors.white,
                                                            onPressed: () {
                                                              print('Download');
                                                            },
                                                            icon: const Icon(
                                                                Icons
                                                                    .download)),
                                                      ])),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Opacity(
                                            opacity: 0.6,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 20,
                                                height: 24)),
                                        Opacity(
                                            opacity: 0.4,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 16,
                                                height: 16)),
                                        Opacity(
                                            opacity: 0.2,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 12,
                                                height: 12)),
                                        Opacity(
                                            opacity: 0.2,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 12,
                                                height: 12)),
                                        Opacity(
                                            opacity: 0.4,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 16,
                                                height: 16)),
                                        Opacity(
                                            opacity: 0.6,
                                            child: SvgPicture.asset(
                                                'assets/images/star_4.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color.fromARGB(
                                                            255, 241, 198, 255),
                                                        BlendMode.srcIn),
                                                width: 20,
                                                height: 24))
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '- 樂觀、自發性以及對未知的擁抱 -',
                                      style: TextStyle(
                                          height: 1.0,
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '描繪一位年輕人站在懸崖邊緣，代表旅程的開始。餘人背著一個小袋，象徵他們擁有的潛力和資源。身後升起的太陽預示著新的開始和冒險的承諾。愚人通常有一隻狗相伴，代表忠誠和保護。',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 12 / 7,
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                                255, 241, 198, 255)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(children: [
                                        ...List.generate(
                                            _data.length,
                                            (index) =>
                                                TarotNightTestResultExpandablePanel(
                                                  isFirstElement: index == 0,
                                                  isLastElement:
                                                      index == _data.length - 1,
                                                  header: _data[index].title,
                                                  body:
                                                      _data[index].description,
                                                ))
                                      ]),
                                    )
                                  ],
                                )),
                          ]),
                        ))));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
  }
}

class DescriptionItem {
  final String title;
  final String description;
  bool isExpanded;

  DescriptionItem(
      {required this.title,
      required this.description,
      this.isExpanded = false});
}
