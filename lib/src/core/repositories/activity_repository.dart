import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/activity_info.dart';

part 'activity_repository.g.dart';

class ActivityRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Get Activity List
  Future<List<ActivityInfo>> getActivityList() async {
    final snapshot = await _fireStore.collection('activities').get();
    return snapshot.docs
        .map((activity) => ActivityInfo.fromMap(activity.data()))
        .toList();
  }
}

@riverpod
ActivityRepository activityRepository(ActivityRepositoryRef ref) =>
    ActivityRepository();
