import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/repositories/activity_repository.dart';
import 'package:tata/src/core/models/activity_info.dart';

part 'activity_provider.g.dart';

@riverpod
class Activity extends _$Activity {
  late List<ActivityInfo> _activityList = [];

  Future<void> loadActivityList() async {
    _activityList =
        await ref.read(activityRepositoryProvider).getActivityList();
  }

  @override
  FutureOr<List<ActivityInfo>> build() async {
    _activityList =
        await ref.read(activityRepositoryProvider).getActivityList();

    return _activityList;
  }
}
