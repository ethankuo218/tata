import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/models/activity.dart';

class ActivityService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Get activity list
  Stream<List<Activity>> getActivityList() {
    return _fireStore.collection('activities').snapshots().map((snapshot) =>
        snapshot.docs
            .map((activity) => Activity.fromMap(activity.data()))
            .toList());
  }
}
