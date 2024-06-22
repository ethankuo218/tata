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
              enlargeCenterPage: true,
              viewportFraction: 0.8,
              padEnds: true,
              enableInfiniteScroll: true,
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
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 241, 198, 255)
                        .withOpacity(current == entry.key ? 1 : 0.5)),
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
      alignment: Alignment.topCenter,
      children: [
        Container(
            width: 281,
            height: constraints.maxHeight - 16,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 241, 198, 255).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              alignment: Alignment.topCenter,
              width: 265,
              height: constraints.maxHeight,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 241, 198, 255),
                      width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 48,
                        child: const Column(
                          children: [
                            Text(
                              "探索心靈的奧秘      ",
                              style: TextStyle(
                                  height: 1.5,
                                  color: Color.fromARGB(255, 241, 198, 255),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "      解開內心的困擾",
                              style: TextStyle(
                                height: 1.5,
                                color: Color.fromARGB(255, 241, 198, 255),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 16),
                    const Text(
                      "你可以選擇成為發問者深入探討自己的疑惑，或是化身回答者，透過智慧幫助他人。每晚十一點到凌晨一點，加入我們的聊天室，透過塔羅牌發現問題的答案，共同體驗心靈的交流與成長。你準備好了嗎？讓我們一起揭開生命的神秘面紗。",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }),
  LayoutBuilder(builder: (context, constraints) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
            width: 281,
            height: constraints.maxHeight - 16,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 241, 198, 255).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              alignment: Alignment.topCenter,
              width: 265,
              height: constraints.maxHeight,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 241, 198, 255),
                      width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 48,
                        child: const Text(
                          "遊戲參與者選擇",
                          style: TextStyle(
                              height: 1.5,
                              color: Color.fromARGB(255, 241, 198, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                    const SizedBox(height: 16),
                    const Text(
                      "房主：\n當你感到心中有疑惑或困擾時，創建一個聊天室，並描述你的心理困擾，尋求來自其他參與者的見解與建議。\n\n參加者：\n選擇進入聊天室，抽取一張角色牌，每張角色牌將指引你完成特定的任務，幫助房主釐清困惑。",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }),
  LayoutBuilder(builder: (context, constraints) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
            width: 281,
            height: constraints.maxHeight - 16,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 241, 198, 255).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              alignment: Alignment.topCenter,
              width: 265,
              height: constraints.maxHeight,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 241, 198, 255),
                      width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 48,
                        child: const Text(
                          "遊戲流程與活動時間",
                          style: TextStyle(
                              height: 1.5,
                              color: Color.fromARGB(255, 241, 198, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                    const SizedBox(height: 16),
                    const Text(
                      "• 活動時間：每晚 11:00 至 01:00。\n• 房主在活動開始 30 分鐘後可以進行塔羅牌測驗，輸入想問的問題並抽取一張塔羅牌。\n• 房主將抽出的塔羅牌分享至聊天室。\n• 參加者根據塔羅牌解析提供答案，完成其角色任務。",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  })
];
