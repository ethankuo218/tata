import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/providers/pages/tarot-night/draw_role_view_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_view.dart';

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
                body: isDrew
                    ? SingleChildScrollView(
                        child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 36),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 12, 13, 32),
                                Color.fromARGB(255, 26, 0, 58),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/star_2.svg',
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                '這是你的角色',
                                style: TextStyle(
                                  height: 1.0,
                                  color: Color.fromARGB(255, 223, 130, 255),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 368,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 241, 198, 255),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          child: Image.asset(role!.image,
                                              fit: BoxFit.cover)),
                                    ),
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
                                            colorFilter: const ColorFilter.mode(
                                                Color.fromARGB(
                                                    255, 241, 198, 255),
                                                BlendMode.srcIn),
                                            width: 20,
                                            height: 24)),
                                    Opacity(
                                        opacity: 0.4,
                                        child: SvgPicture.asset(
                                            'assets/images/star_4.svg',
                                            colorFilter: const ColorFilter.mode(
                                                Color.fromARGB(
                                                    255, 241, 198, 255),
                                                BlendMode.srcIn),
                                            width: 16,
                                            height: 16)),
                                    Opacity(
                                        opacity: 0.2,
                                        child: SvgPicture.asset(
                                            'assets/images/star_4.svg',
                                            colorFilter: const ColorFilter.mode(
                                                Color.fromARGB(
                                                    255, 241, 198, 255),
                                                BlendMode.srcIn),
                                            width: 12,
                                            height: 12)),
                                    Opacity(
                                        opacity: 0.2,
                                        child: SvgPicture.asset(
                                            'assets/images/star_4.svg',
                                            colorFilter: const ColorFilter.mode(
                                                Color.fromARGB(
                                                    255, 241, 198, 255),
                                                BlendMode.srcIn),
                                            width: 12,
                                            height: 12)),
                                    Opacity(
                                        opacity: 0.4,
                                        child: SvgPicture.asset(
                                            'assets/images/star_4.svg',
                                            colorFilter: const ColorFilter.mode(
                                                Color.fromARGB(
                                                    255, 241, 198, 255),
                                                BlendMode.srcIn),
                                            width: 16,
                                            height: 16)),
                                    Opacity(
                                        opacity: 0.6,
                                        child: SvgPicture.asset(
                                            'assets/images/star_4.svg',
                                            colorFilter: const ColorFilter.mode(
                                                Color.fromARGB(
                                                    255, 241, 198, 255),
                                                BlendMode.srcIn),
                                            width: 20,
                                            height: 24))
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text('- ${role.name} -',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      height: 1.0,
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(height: 16),
                                Text(role.description,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      height: 12 / 7,
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(height: 20),
                                Text('接下來，\n請以一顆樂觀開朗的心，為房主帶來希望的曙光！',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      height: 12 / 7,
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    context.pushReplacement(
                                        TarotNightRoomView.routeName,
                                        extra: roomId);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    backgroundColor: const Color.fromARGB(
                                        255, 223, 130, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    '開始聊天',
                                    style: TextStyle(
                                      height: 1.2,
                                      color: Color.fromARGB(255, 12, 13, 32),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ))
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 36),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 12, 13, 32),
                                Color.fromARGB(255, 26, 0, 58),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/star_5.svg',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              '進入聊天室前，\n需要拾起你的神秘角色和任務！',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 7 / 5,
                                color: Color.fromARGB(255, 241, 198, 255),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SvgPicture.asset('assets/images/star_2.svg',
                                width: 12,
                                height: 12,
                                colorFilter: ColorFilter.mode(
                                    const Color.fromARGB(255, 241, 198, 255)
                                        .withOpacity(0.2),
                                    BlendMode.srcIn)),
                            const SizedBox(height: 20),
                            SvgPicture.asset('assets/images/star_2.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                    const Color.fromARGB(255, 241, 198, 255)
                                        .withOpacity(0.4),
                                    BlendMode.srcIn)),
                            const SizedBox(height: 20),
                            SvgPicture.asset('assets/images/star_2.svg',
                                width: 30,
                                height: 30,
                                colorFilter: ColorFilter.mode(
                                    const Color.fromARGB(255, 241, 198, 255)
                                        .withOpacity(0.6),
                                    BlendMode.srcIn)),
                            const SizedBox(height: 20),
                            SvgPicture.asset('assets/images/star_2.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                    const Color.fromARGB(255, 241, 198, 255)
                                        .withOpacity(0.4),
                                    BlendMode.srcIn)),
                            const SizedBox(height: 20),
                            SvgPicture.asset('assets/images/star_2.svg',
                                width: 12,
                                height: 12,
                                colorFilter: ColorFilter.mode(
                                    const Color.fromARGB(255, 241, 198, 255)
                                        .withOpacity(0.2),
                                    BlendMode.srcIn)),
                            const Spacer(),
                            const Text(
                              '在今夜的會話落幕前，\n完成它來解鎖心靈的交流。\n每個角色都擁有專屬的使命，\n這將引導本次對話，\n協助解惑他人的煩惱！',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 241, 198, 255),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(
                                        tarotNightDrawRoleViewProvider.notifier)
                                    .drawRole(roomId: roomId);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 223, 130, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                '抽取角色',
                                style: TextStyle(
                                  height: 1.2,
                                  color: Color.fromARGB(255, 12, 13, 32),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        );
  }
}
