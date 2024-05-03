import 'package:freezed_annotation/freezed_annotation.dart';

part "pair_state.freezed.dart";

@freezed
class PairState with _$PairState {
  const factory PairState.initial() = _Initial;

  const factory PairState.loading() = _Loading;

  const factory PairState.success({required String chatRoomId}) = _Success;

  const factory PairState.failed({required String error}) = _Failed;
}
