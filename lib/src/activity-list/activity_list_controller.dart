import 'package:tata/src/services/activity.service.dart';

import '../models/activity.dart';

class ActivityListController {
  Stream<List<Activity>> activityListStream =
      ActivityService().getActivityList();
}
