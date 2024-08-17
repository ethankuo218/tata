import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<Object?> showTarotNightWalkthroughDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, _, __) {
      int current = 0;
      final CarouselController controller = CarouselController();

      double viewHeight = MediaQuery.of(context).size.height;

      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Center(
          child: Container(
            height: viewHeight,
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Stack(children: [
              CarouselSlider(
                  items: walkthroughSliders,
                  carouselController: controller,
                  options: CarouselOptions(
                      height: viewHeight,
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
                height: viewHeight,
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: walkthrough.asMap().entries.map((entry) {
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
                  ],
                ),
              ),
              Container(
                height: viewHeight,
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: Text(current != 4 ? '跳過' : '開始',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white))),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      });
    },
    barrierDismissible: false,
    barrierLabel: "Tarot Night Walkthrough",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
          position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child);
    },
  ).then(onClosed);
}

final List<int> walkthrough = [1, 2, 3, 4, 5];

final List<Widget> walkthroughSliders = [
  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox.shrink(),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 198, 255)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('選角開啟活動 !',
                      style: TextStyle(
                          height: 12 / 7,
                          color: Color.fromARGB(255, 241, 198, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('1. 成為房主，分享您的煩惱\n2.成為參加者，與房主聊聊心事',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 16),
            Container(
                width: 265,
                height: 520,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 241, 198, 255),
                        width: 1),
                    borderRadius: BorderRadius.circular(40)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset('assets/images/walkthrough-1.png',
                      fit: BoxFit.fill),
                ))
          ],
        ),
      )),
  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox.shrink(),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 198, 255)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('房主',
                      style: TextStyle(
                          height: 12 / 7,
                          color: Color.fromARGB(255, 241, 198, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('分享心事',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 241, 198, 255))),
            const Text('開啟專屬你的塔羅測驗！',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white)),
            const SizedBox(height: 16),
            Container(
              width: 265,
              height: 520,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 241, 198, 255),
                      width: 1),
                  borderRadius: BorderRadius.circular(40)),
              child: Image.asset('assets/images/walkthrough-2.png',
                  fit: BoxFit.fill),
            )
          ],
        ),
      )),
  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox.shrink(),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 198, 255)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('房主',
                      style: TextStyle(
                          height: 12 / 7,
                          color: Color.fromARGB(255, 241, 198, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
                const SizedBox(width: 8),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 198, 255)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('參加者',
                      style: TextStyle(
                          height: 12 / 7,
                          color: Color.fromARGB(255, 241, 198, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Text('查看測驗結果',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 241, 198, 255))),
            const Text('讓塔羅一窺內心的煩惱並提供建議!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white)),
            const SizedBox(height: 16),
            Container(
              width: 265,
              height: 520,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 241, 198, 255),
                      width: 1),
                  borderRadius: BorderRadius.circular(40)),
              child: Image.asset('assets/images/walkthrough-3.png',
                  fit: BoxFit.fill),
            )
          ],
        ),
      )),
  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox.shrink(),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 198, 255)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('參加者',
                      style: TextStyle(
                          height: 12 / 7,
                          color: Color.fromARGB(255, 241, 198, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('隨機角色',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 241, 198, 255))),
            const Text('進入聊天室前，先抽取本次擔任的角色!!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white)),
            const SizedBox(height: 16),
            Container(
              width: 265,
              height: 520,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 241, 198, 255),
                      width: 1),
                  borderRadius: BorderRadius.circular(40)),
              child: Image.asset('assets/images/walkthrough-4.png',
                  fit: BoxFit.fill),
            )
          ],
        ),
      )),
  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox.shrink(),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 198, 255)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('參加者',
                      style: TextStyle(
                          height: 12 / 7,
                          color: Color.fromARGB(255, 241, 198, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('根據角色特質，解鎖任務',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 241, 198, 255))),
            const Text('您的回覆，將會帶給房主滿滿的動力！',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white)),
            const SizedBox(height: 16),
            Container(
              width: 265,
              height: 520,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 241, 198, 255),
                      width: 1),
                  borderRadius: BorderRadius.circular(40)),
              child: Image.asset('assets/images/walkthrough-5.png',
                  fit: BoxFit.fill),
            )
          ],
        ),
      )),
];
