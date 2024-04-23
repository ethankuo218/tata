import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tata/src/activity-list/activity_list_controller.dart';
import 'package:tata/src/activity-list/components/activity_list_tile.dart';
import 'package:tata/src/models/activity.dart';
import 'package:tata/src/services/activity.service.dart';

class ActivityListView extends StatefulWidget {
  const ActivityListView({super.key, required this.controller});

  final ActivityListController controller;

  @override
  State<ActivityListView> createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(children: [
              const SizedBox(height: 10),
              Expanded(
                  child: StreamBuilder(
                      builder: (BuildContext context,
                              AsyncSnapshot<List<Activity>> activityList) =>
                          ListView.separated(
                              itemBuilder: (context, index) => ActivityListTile(
                                  activityInfo: activityList.data![index]),
                              itemCount: activityList.data != null
                                  ? activityList.data!.length
                                  : 0,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 10)),
                      stream: ActivityService().getActivityList()))
            ])));
  }
}
