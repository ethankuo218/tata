import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/create_room_bottom_sheet.dart';

class TarotNightRoomInfoView extends StatelessWidget {
  final TarotNightRoom roomInfo;
  const TarotNightRoomInfoView({super.key, required this.roomInfo});

  static const String routeName = 'room-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 13, 32),
        title: const Text('Room info',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        centerTitle: true,
        titleSpacing: 0,
      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 12, 13, 32),
                Color.fromARGB(255, 26, 0, 58)
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 72,
                    child: Column(
                      children: [
                        const SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/star_2.svg'),
                            const SizedBox(width: 16),
                            const Text(
                              '占星塔羅夜',
                              style: TextStyle(
                                  height: 1.0,
                                  color: Color.fromARGB(255, 223, 130, 255),
                                  fontSize: 24,
                                  fontFamily: 'MedievalSharp'),
                            ),
                            const SizedBox(width: 16),
                            SvgPicture.asset('assets/images/star_2.svg'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 85,
                    top: 8,
                    child: Opacity(
                      opacity: 0.5,
                      child: SvgPicture.asset(
                        'assets/images/star_1.svg',
                        width: 42.32,
                        height: 42.32,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text('我是Slogan 我是Slogan 我是Slogan',
                  style: TextStyle(
                    height: 1.0,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  )),
              const SizedBox(height: 32),
              Stack(
                children: [
                  Transform.rotate(
                    angle: 0.025,
                    child: Container(
                      height: 566,
                      width: 336,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 198, 255)
                            .withOpacity(0.1),
                        border: GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 223, 130, 255)
                                    .withOpacity(0.8),
                                const Color.fromARGB(255, 241, 198, 255)
                                    .withOpacity(0.2),
                                const Color.fromARGB(255, 223, 130, 255)
                                    .withOpacity(0.8),
                                const Color.fromARGB(255, 241, 198, 255)
                                    .withOpacity(0.2),
                              ],
                            ),
                            width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -0.025,
                    child: Container(
                      height: 566,
                      width: 336,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 198, 255)
                            .withOpacity(0.1),
                        border: GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 223, 130, 255)
                                    .withOpacity(0.8),
                                const Color.fromARGB(255, 241, 198, 255)
                                    .withOpacity(0.2),
                                const Color.fromARGB(255, 223, 130, 255)
                                    .withOpacity(0.8),
                                const Color.fromARGB(255, 241, 198, 255)
                                    .withOpacity(0.2),
                              ],
                            ),
                            width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 566,
                    width: 336,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                color: Colors.white,
                                iconSize: 16,
                                padding: EdgeInsets.zero,
                                onPressed: () => {
                                      showCreateTarotNightRoomBottomSheet(
                                          context, onClosed: (_) {
                                        if (_ == null) {
                                          return;
                                        }
                                      })
                                    },
                                icon:
                                    const FaIcon(FontAwesomeIcons.penToSquare))
                          ],
                        ),
                        Text(
                          '- 此刻的心境 -',
                          style: TextStyle(
                            height: 1.0,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          roomInfo.title,
                          style: const TextStyle(
                            height: 1.0,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Opacity(
                                opacity: 0.6,
                                child: SvgPicture.asset(
                                  'assets/images/star_2.svg',
                                  width: 30,
                                  height: 30,
                                )),
                            const SizedBox(width: 8),
                            Opacity(
                                opacity: 0.4,
                                child: SvgPicture.asset(
                                  'assets/images/star_2.svg',
                                  width: 20,
                                  height: 20,
                                )),
                            const SizedBox(width: 8),
                            Opacity(
                                opacity: 0.2,
                                child: SvgPicture.asset(
                                  'assets/images/star_2.svg',
                                  width: 12,
                                  height: 12,
                                )),
                            const SizedBox(width: 8),
                            Opacity(
                                opacity: 0.2,
                                child: SvgPicture.asset(
                                  'assets/images/star_2.svg',
                                  width: 12,
                                  height: 12,
                                )),
                            const SizedBox(width: 8),
                            Opacity(
                                opacity: 0.4,
                                child: SvgPicture.asset(
                                  'assets/images/star_2.svg',
                                  width: 20,
                                  height: 20,
                                )),
                            const SizedBox(width: 8),
                            Opacity(
                                opacity: 0.6,
                                child: SvgPicture.asset(
                                  'assets/images/star_2.svg',
                                  width: 30,
                                  height: 30,
                                )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 198, 255)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            TarotNightRoomTheme.toText(roomInfo.theme),
                            style: const TextStyle(
                              height: 1.0,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          '- 內心小煩惱 -',
                          style: TextStyle(
                            height: 1.0,
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          roomInfo.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
