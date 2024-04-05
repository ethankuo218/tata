import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tata/src/activity-list/components/activity_list_tile.dart';
import 'package:tata/src/models/activity.dart';
import 'package:tata/src/services/activity.service.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(children: [
              Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 137, 118, 82)
                          .withOpacity(0.2),
                      border: Border.all(
                          color: const Color.fromARGB(255, 137, 118, 82)
                              .withOpacity(0.6),
                          width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: BackdropFilter(
                      blendMode: BlendMode.overlay,
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ))),
              const SizedBox(height: 30),
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
