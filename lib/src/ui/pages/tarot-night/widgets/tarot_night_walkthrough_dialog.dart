import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<Object?> showTarotNightWalkthroughDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, _, __) {
      int current = 0;
      final CarouselController controller = CarouselController();
      bool isChecked = false;

      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Center(
          child: Container(
            height: screenHeight * 0.45,
            width: screenWidth * 0.9,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: Stack(children: [
              CarouselSlider(
                  items: walkthroughSliders,
                  carouselController: controller,
                  options: CarouselOptions(
                      height: screenHeight * 0.45,
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
                height: screenHeight * 0.45,
                width: screenWidth * 0.9,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              }),
                          const Text("Don't show again",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
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
                height: screenHeight * 0.45,
                width: screenWidth * 0.9,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      context.pop(true);
                    }),
              )
            ]),
          ),
        );
      });
    },
    barrierDismissible: false,
    barrierLabel: "Tarot Night Walkthrough",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
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

final List<Widget> walkthroughSliders = walkthrough
    .map((item) => Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  border: Border.all(
                      color: const Color.fromARGB(255, 137, 118, 82)
                          .withOpacity(0.6),
                      width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset("assets/images/star.png", fit: BoxFit.contain),
            )
          ],
        ))
    .toList();
