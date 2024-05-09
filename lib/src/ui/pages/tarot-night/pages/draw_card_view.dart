import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TarotNightDrawCardView extends ConsumerWidget {
  const TarotNightDrawCardView({super.key});

  static const routeName = '/tarot-night/draw-card';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            const Text(
              '在您抽牌前，請先做一次深呼吸，讓心靈平靜下來。',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('閉上眼睛，想想您想問的問題以及相關的人事物，與塔羅牌卡做深層的連結。',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 16),
            const Text('最後，將眼睛睜開，輕輕抽取一張，讓直覺引領您走向答案。',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            const SizedBox(height: 60),
            Stack(
              children: [
                Container(
                  width: 200,
                  height: 250,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 137, 118, 82)
                          .withOpacity(0.3),
                      border: Border.all(
                          color: const Color.fromARGB(255, 137, 118, 82)
                              .withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: 200,
                  height: 250,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    'assets/images/star.png',
                    opacity: const AlwaysStoppedAnimation(0.5),
                  ),
                ),
                BackdropFilter(
                    blendMode: BlendMode.overlay,
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      width: 200,
                      height: 250,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ))
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Draw card
              },
              child: const Text('選中此牌'),
            ),
          ],
        ),
      ),
    );
  }
}
