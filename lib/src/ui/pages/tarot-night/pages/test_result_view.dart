import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tata/src/ui/shared/widgets/app_bar.dart';

class TarotNightTestResultView extends ConsumerStatefulWidget {
  const TarotNightTestResultView({super.key});

  static const routeName = '/tarot-night/test-result';

  @override
  ConsumerState<TarotNightTestResultView> createState() =>
      _TarotNightTestResultViewState();
}

class _TarotNightTestResultViewState
    extends ConsumerState<TarotNightTestResultView> {
  final List<DescriptionItem> _data = [
    DescriptionItem(
      title: '工作',
      description:
          '表示將有轉職的機會，或是可以開始進行自己夢寐以求的事情。已經有工作的朋友，也有機會會晉升，繼續努力，會有意想不到的好成績等著你。',
    ),
    DescriptionItem(
      title: '友情',
      description: '你的朋友清單似乎每天都在增長，因為你喜歡結識新朋友。但這並不意味著要忘記那些在你困難時期一直陪伴在你身邊的老朋友。',
    ),
    DescriptionItem(
      title: '感情',
      description:
          '在愛情方面，愚人牌通常是令人興奮、無憂無慮的浪漫遭遇的標誌。它可以指向一段新關係的開始，一見鍾情或是熱戀，雖然愛得熱烈，但是都來自衝動，是否為真愛還需審慎思考。',
    ),
    DescriptionItem(
      title: '家庭',
      description:
          '在家庭環境中，愚人可能表示一個重大變化的時期或家庭的新成員，如出生、搬家。它也可以表明現在是打破傳統家庭束縛，並以善意的意圖開創自己道路的時候。',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(),
        body: SingleChildScrollView(
            child: Column(children: [
          const Center(
              child: Text('測驗解析來囉！',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
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
                            color: const Color.fromARGB(255, 137, 118, 82)
                                .withOpacity(0.6),
                            width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset('assets/images/tarot/fool.png',
                            fit: BoxFit.cover))),
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 137, 118, 82)
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
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(7))),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('這次會抽到 bts 演唱會的票嗎？',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                    '你需要更深的反思或更多地聽從你選擇的直覺，不要考慮太多，跟從自己的內心，或許會有意想不到的好事發生。',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ),
                              Row(children: [
                                const Spacer(),
                                IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    color: Colors.white,
                                    onPressed: () {
                                      print('Share');
                                    },
                                    icon: const Icon(Icons.share)),
                                IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    color: Colors.white,
                                    onPressed: () {
                                      print('Download');
                                    },
                                    icon: const Icon(Icons.download)),
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
                  color:
                      const Color.fromARGB(255, 137, 118, 82).withOpacity(0.2),
                  border: Border.all(
                      color: const Color.fromARGB(255, 137, 118, 82)
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
                    style: TextStyle(color: Colors.white, fontSize: 14),
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
                        backgroundColor: const Color.fromARGB(255, 137, 118, 82)
                            .withOpacity(0.6),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(_data[index].title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          );
                        },
                        body: ListTile(
                          title: Text(_data[index].description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14)),
                        ),
                        isExpanded: _data[index].isExpanded,
                      )),
            ),
          ),
        ])));
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
