import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/core/models/tarot_card.dart';
import 'package:tata/src/core/repositories/reference_repository.dart';
import 'package:tata/src/core/repositories/tarot_night_room_repository.dart';
import 'package:tata/src/core/repositories/user_repository.dart';

part 'draw_card_view_provider.g.dart';

@riverpod
class TarotNightDrawCardView extends _$TarotNightDrawCardView {
  TarotCard? _card;
  AppUserInfo? _userInfo;

  @override
  Future<TarotCard?> build() async {
    state = AsyncData(_card);
    _userInfo = await ref
        .read(userRepositoryProvider)
        .getUserInfo(FirebaseAuth.instance.currentUser!.uid);
    return Future(() => null);
  }

  Future<void> drawCard(
      {required String roomId, required String question}) async {
    // final int number = Random().nextInt(22) + 1;
    const int number = 1;
    _card = await ref
        .read(referenceRepositoryProvider)
        .getTarotCard(number.toString());
    await ref.read(tarotNightRoomRepositoryProvider).updateDrawCardResult(
        userInfo: _userInfo!,
        roomId: roomId,
        question: question,
        card: number.toString());
    state = AsyncData(_card);
  }
}
