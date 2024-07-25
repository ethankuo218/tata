import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    Locale currentLocale = Localizations.localeOf(context);

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
                        child: Column(
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.activity_lobby_activity_introduction_title_1_1}      ',
                              textAlign:
                                  currentLocale == const Locale('zh', 'Hant')
                                      ? TextAlign.start
                                      : TextAlign.center,
                              style: const TextStyle(
                                  height: 1.5,
                                  color: Color.fromARGB(255, 241, 198, 255),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            if (currentLocale == const Locale('zh', 'Hant'))
                              Text(
                                '       ${AppLocalizations.of(context)!.activity_lobby_activity_introduction_title_1_2}',
                                style: const TextStyle(
                                    height: 1.5,
                                    color: Color.fromARGB(255, 241, 198, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                          ],
                        )),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!
                          .activity_lobby_activity_introduction_description_1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
                        child: Text(
                          AppLocalizations.of(context)!
                              .activity_lobby_activity_introduction_title_2,
                          style: const TextStyle(
                              height: 1.5,
                              color: Color.fromARGB(255, 241, 198, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!
                          .activity_lobby_activity_introduction_description_2,
                      style: const TextStyle(
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
                        child: Text(
                          AppLocalizations.of(context)!
                              .activity_lobby_activity_introduction_title_3,
                          style: const TextStyle(
                              height: 1.5,
                              color: Color.fromARGB(255, 241, 198, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!
                          .activity_lobby_activity_introduction_description_3,
                      style: const TextStyle(
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
