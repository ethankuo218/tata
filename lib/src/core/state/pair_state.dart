import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tata/src/core/models/chat_room.dart';

part "pair_state.freezed.dart";

@freezed
class PairState with _$PairState {
  const factory PairState.initial() = _Initial;

  const factory PairState.loading() = _Loading;

  const factory PairState.success({required ChatRoom chatRoomInfo}) = _Success;

  const factory PairState.failed({required String error}) = _Failed;
}
