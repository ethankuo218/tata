import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/providers/pages/tarot-night/draw_role_view_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TarotNightDrawRoleView extends ConsumerWidget {
  const TarotNightDrawRoleView({super.key, required this.roomId});

  final String roomId;
  static const routeName = '/tarot-night/draw-role';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(tarotNightDrawRoleViewProvider).when(
          data: (role) {
            late bool isDrew = role != null;

            return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 12, 13, 32),
                  leading: const SizedBox.shrink(),
                ),
                body: BottomBar(
                    offset: 30,
                    barColor: Colors.transparent,
                    child: SizedBox(
                        height: 48,
                        width: 160.5,
                        child: FittedBox(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor:
                                    const Color.fromARGB(255, 223, 130, 255),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12)),
                            onPressed: () {
                              if (isDrew) {
                                context.pushReplacement(
                                    TarotNightRoomView.routeName,
                                    extra: roomId);
                              } else {
                                ref
                                    .read(
                                        tarotNightDrawRoleViewProvider.notifier)
                                    .drawRole(roomId: roomId);
                              }
                            },
                            child: Text(
                                isDrew
                                    ? AppLocalizations.of(context)!
                                        .activity_draw_role_start_chat
                                    : AppLocalizations.of(context)!
                                        .activity_draw_role_draw_card,
                                style: const TextStyle(
                                    height: 1.0,
                                    color: Color.fromARGB(255, 12, 13, 32),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        )),
                    body: (context, controller) => Column(
                          children: [
                            Expanded(
                              child: Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 20, 16, 36),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 12, 13, 32),
                                          Color.fromARGB(255, 26, 0, 58),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                  ),
                                  child: SingleChildScrollView(
                                    child: isDrew
                                        ? Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/star_2.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    const SizedBox(width: 16),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .activity_draw_your_role,
                                                      style: const TextStyle(
                                                        height: 1.0,
                                                        color: Color.fromARGB(
                                                            255, 223, 130, 255),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    SvgPicture.asset(
                                                      'assets/images/star_2.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 24),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            height: 320,
                                                            width: 320,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    241,
                                                                    198,
                                                                    255),
                                                                width: 3,
                                                              ),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            13),
                                                                child: Image.asset(
                                                                    role!.image,
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                          SizedBox(
                                                            height: 320,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Opacity(
                                                                          opacity:
                                                                              0.6,
                                                                          child: SvgPicture.asset(
                                                                              'assets/images/star_4.svg',
                                                                              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 241, 198, 255), BlendMode.srcIn),
                                                                              width: 20,
                                                                              height: 24)),
                                                                      const Spacer(),
                                                                      Opacity(
                                                                          opacity:
                                                                              0.6,
                                                                          child: SvgPicture.asset(
                                                                              'assets/images/star_4.svg',
                                                                              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 241, 198, 255), BlendMode.srcIn),
                                                                              width: 20,
                                                                              height: 24))
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          40),
                                                                  child: Row(
                                                                    children: [
                                                                      Opacity(
                                                                          opacity:
                                                                              0.4,
                                                                          child: SvgPicture.asset(
                                                                              'assets/images/star_4.svg',
                                                                              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 241, 198, 255), BlendMode.srcIn),
                                                                              width: 16,
                                                                              height: 16)),
                                                                      const Spacer(),
                                                                      Opacity(
                                                                          opacity:
                                                                              0.4,
                                                                          child: SvgPicture.asset(
                                                                              'assets/images/star_4.svg',
                                                                              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 241, 198, 255), BlendMode.srcIn),
                                                                              width: 16,
                                                                              height: 16)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          68),
                                                                  child: Row(
                                                                    children: [
                                                                      Opacity(
                                                                          opacity:
                                                                              0.2,
                                                                          child: SvgPicture.asset(
                                                                              'assets/images/star_4.svg',
                                                                              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 241, 198, 255), BlendMode.srcIn),
                                                                              width: 12,
                                                                              height: 12)),
                                                                      const Spacer(),
                                                                      Opacity(
                                                                          opacity:
                                                                              0.2,
                                                                          child: SvgPicture.asset(
                                                                              'assets/images/star_4.svg',
                                                                              colorFilter: const ColorFilter.mode(Color.fromARGB(255, 241, 198, 255), BlendMode.srcIn),
                                                                              width: 12,
                                                                              height: 12))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 40),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: List.generate(
                                                            role.tags.length,
                                                            (index) =>
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      right: index ==
                                                                              role.tags.length - 1
                                                                          ? 0
                                                                          : 8),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          2),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            241,
                                                                            198,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child: Text(
                                                                      role.tags[
                                                                          index],
                                                                      style:
                                                                          const TextStyle(
                                                                        height:
                                                                            12 /
                                                                                7,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            241,
                                                                            198,
                                                                            255),
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      )),
                                                                )),
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Text('- ${role.name} -',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            height: 1.0,
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      const SizedBox(
                                                          height: 16),
                                                      Text(role.description,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            height: 12 / 7,
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      const SizedBox(
                                                          height: 20),
                                                      Text(role.intro,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            height: 12 / 7,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ))
                                                    ],
                                                  ),
                                                )
                                              ])
                                        : Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/star_5.svg',
                                                width: 40,
                                                height: 40,
                                              ),
                                              const SizedBox(height: 24),
                                              Text(
                                                role!.intro,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  height: 7 / 5,
                                                  color: Color.fromARGB(
                                                      255, 241, 198, 255),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              SvgPicture.asset(
                                                  'assets/images/star_2.svg',
                                                  width: 12,
                                                  height: 12,
                                                  colorFilter: ColorFilter.mode(
                                                      const Color.fromARGB(255,
                                                              241, 198, 255)
                                                          .withOpacity(0.2),
                                                      BlendMode.srcIn)),
                                              const SizedBox(height: 20),
                                              SvgPicture.asset(
                                                  'assets/images/star_2.svg',
                                                  width: 20,
                                                  height: 20,
                                                  colorFilter: ColorFilter.mode(
                                                      const Color.fromARGB(255,
                                                              241, 198, 255)
                                                          .withOpacity(0.4),
                                                      BlendMode.srcIn)),
                                              const SizedBox(height: 20),
                                              SvgPicture.asset(
                                                  'assets/images/star_2.svg',
                                                  width: 30,
                                                  height: 30,
                                                  colorFilter: ColorFilter.mode(
                                                      const Color.fromARGB(255,
                                                              241, 198, 255)
                                                          .withOpacity(0.6),
                                                      BlendMode.srcIn)),
                                              const SizedBox(height: 20),
                                              SvgPicture.asset(
                                                  'assets/images/star_2.svg',
                                                  width: 20,
                                                  height: 20,
                                                  colorFilter: ColorFilter.mode(
                                                      const Color.fromARGB(255,
                                                              241, 198, 255)
                                                          .withOpacity(0.4),
                                                      BlendMode.srcIn)),
                                              const SizedBox(height: 20),
                                              SvgPicture.asset(
                                                  'assets/images/star_2.svg',
                                                  width: 12,
                                                  height: 12,
                                                  colorFilter: ColorFilter.mode(
                                                      const Color.fromARGB(255,
                                                              241, 198, 255)
                                                          .withOpacity(0.2),
                                                      BlendMode.srcIn)),
                                              const SizedBox(height: 115),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .activity_draw_role_description_2,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 241, 198, 255),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                  )),
                            )
                          ],
                        )));
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        );
  }
}
