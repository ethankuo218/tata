import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_card.dart';
import 'package:tata/src/core/providers/tarot-night/test_result_view_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_view.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/quest_bottom_sheet.dart';
import 'package:tata/src/ui/shared/widgets/app_bar.dart';

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
                appBar: const AppBarWidget(),
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
                                    context.go(TarotNightRoomView.routeName,
                                        extra: roomInfo.id);
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
                            child: Column(children: [
                          const Center(
                              child: Text('測驗解析來囉！',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Stack(
                              children: [
                                Container(
                                    height: 350,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                    255, 137, 118, 82)
                                                .withOpacity(0.6),
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(card.image,
                                            fit: BoxFit.cover))),
                                Container(
                                  height: 350,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                                  255, 137, 118, 82)
                                              .withOpacity(0.6),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Spacer(),
                                      Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(7))),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(roomInfo.question!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18)),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                height: 1,
                                                width: double.infinity,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(card.description,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14)),
                                              ),
                                              Row(children: [
                                                const Spacer(),
                                                IconButton(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      print('Share');
                                                    },
                                                    icon: const Icon(
                                                        Icons.share)),
                                                IconButton(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      print('Download');
                                                    },
                                                    icon: const Icon(
                                                        Icons.download)),
                                              ]),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 137, 118, 82)
                                      .withOpacity(0.2),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                              255, 137, 118, 82)
                                          .withOpacity(0.6),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.all(10),
                              child: const Column(
                                children: [
                                  Text('[ 樂觀、自發性以及對未知的擁抱 ]',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Text(
                                    '描繪一位年輕人站在懸崖邊緣，代表旅程的開始。愚人背著一個小袋，象徵他們擁有的潛力和資源。身後升起的太陽預示著新的開始和冒險的承諾。愚人通常有一隻狗相伴，代表忠誠和保護。',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ExpansionPanelList(
                              materialGapSize: 0,
                              dividerColor: Colors.white.withOpacity(0.4),
                              expandIconColor: Colors.white,
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  _data[index].isExpanded = isExpanded;
                                });
                              },
                              children: List.generate(
                                  _data.length,
                                  (index) => ExpansionPanel(
                                        backgroundColor: const Color.fromARGB(
                                                255, 137, 118, 82)
                                            .withOpacity(0.6),
                                        headerBuilder: (BuildContext context,
                                            bool isExpanded) {
                                          return ListTile(
                                            title: Text(_data[index].title,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          );
                                        },
                                        body: ListTile(
                                          title: Text(_data[index].description,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                        ),
                                        isExpanded: _data[index].isExpanded,
                                      )),
                            ),
                          ),
                          const SizedBox(height: 90),
                        ]))));
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
