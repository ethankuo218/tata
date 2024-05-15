import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/tarot_card.dart';
import 'package:tata/src/core/repositories/reference_repository.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';

part 'draw_card_view_provider.g.dart';

@riverpod
class TarotNightDrawCardView extends _$TarotNightDrawCardView {
  TarotCard? _card;

  @override
  Future<TarotCard?> build() {
    state = AsyncData(_card);
    return Future(() => null);
  }

  Future<void> drawCard(
      {required String roomId, required String question}) async {
    // final int number = Random().nextInt(22) + 1;
    const int number = 1;
    _card = await ref
        .read(referenceRepositoryProvider)
        .getTarotCard(number.toString());
    await ref
        .read(tarotNightRoomRepositoryProvider)
        .updateDrawCardResult(roomId, question, number.toString());
    state = AsyncData(_card);
  }
}
