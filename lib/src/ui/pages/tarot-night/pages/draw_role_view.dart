import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/providers/tarot-night/draw_role_view_provider.dart';
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
                title: const Text('Draw Role'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: isDrew
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 450,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 137, 118, 82)
                                          .withOpacity(0.3),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                                  255, 137, 118, 82)
                                              .withOpacity(0.6),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Container(
                                  height: 450,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Image.asset(
                                    role!.image,
                                    opacity: const AlwaysStoppedAnimation(0.5),
                                  ),
                                ),
                                Container(
                                  height: 450,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                                  255, 137, 118, 82)
                                              .withOpacity(0.6),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Spacer(),
                                      Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              border: const Border(
                                                top: BorderSide.none,
                                                right: BorderSide(
                                                    width: 2,
                                                    color: Colors.transparent),
                                                bottom: BorderSide(
                                                    width: 2,
                                                    color: Colors.transparent),
                                                left: BorderSide(
                                                    width: 2,
                                                    color: Colors.transparent),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    Text(role.name,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20)),
                                                    ...List.generate(
                                                        role.tags.length,
                                                        (index) => Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 5),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          2),
                                                              decoration: BoxDecoration(
                                                                  color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          137,
                                                                          118,
                                                                          82)
                                                                      .withOpacity(
                                                                          0.6),
                                                                  border: Border.all(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          137,
                                                                          118,
                                                                          82),
                                                                      width: 1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(8)),
                                                              child: Text(
                                                                  role.tags[
                                                                      index],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12)),
                                                            )),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                height: 1,
                                                width: double.infinity,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                              const SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(role.description,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14)),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                BackdropFilter(
                                    blendMode: BlendMode.overlay,
                                    filter:
                                        ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                    child: Container(
                                      height: 450,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.0)),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                context.push(TarotNightRoomView.routeName,
                                    extra: roomId);
                              },
                              child: const Text('開始聊天'),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 450,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 137, 118, 82)
                                          .withOpacity(0.3),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                                  255, 137, 118, 82)
                                              .withOpacity(0.6),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Container(
                                  height: 450,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Image.asset(
                                    'assets/images/star.png',
                                    opacity: const AlwaysStoppedAnimation(0.5),
                                  ),
                                ),
                                Container(
                                  height: 450,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(30.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          '進入聊天室，拾起你的神秘角色和任務。',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: 32),
                                        Text(
                                            textAlign: TextAlign.center,
                                            '在今夜的會話落幕前，完成它來解鎖心靈的交流。每個角色都擁有專屬的使命，這將引導本次對話，協助解惑他人的煩惱！',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                                BackdropFilter(
                                    blendMode: BlendMode.overlay,
                                    filter:
                                        ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                    child: Container(
                                      height: 450,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.0)),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(
                                        tarotNightDrawRoleViewProvider.notifier)
                                    .drawRole(roomId: roomId);
                              },
                              child: const Text('抽取角色'),
                            ),
                          ],
                        ),
                ),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        );
  }
}
