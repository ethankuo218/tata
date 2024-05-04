import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LobbyIntroductionSlider extends StatefulWidget {
  const LobbyIntroductionSlider({super.key});

  @override
  State<LobbyIntroductionSlider> createState() =>
      _LobbyIntroductionSliderState();
}

class _LobbyIntroductionSliderState extends State<LobbyIntroductionSlider> {
  int current = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          children: introduction.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      )
    ]);
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
