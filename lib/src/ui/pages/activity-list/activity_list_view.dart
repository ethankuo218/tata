import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/activity_info.dart';
import 'package:tata/src/core/providers/activity_provider.dart';
import 'package:tata/src/ui/pages/activity-list/widgets/activity_list_tile.dart';
import 'package:tata/src/ui/pages/tarot-night/lobby_view.dart';

class ActivityListView extends ConsumerStatefulWidget {
  const ActivityListView({super.key});

  @override
  ConsumerState<ActivityListView> createState() => _ActivityListViewState();
}

class _ActivityListViewState extends ConsumerState<ActivityListView> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<ActivityInfo>> activityList =
        ref.watch(activityProvider);

    return activityList.when(
      data: (activityList) => Scaffold(
          body: RefreshIndicator(
              onRefresh: () =>
                  ref.read(activityProvider.notifier).loadActivityList(),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(children: [
                    const SizedBox(height: 10),
                    Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  context.push(LobbyView.routeName);
                                },
                                child: ActivityListTile(
                                    activityInfo: activityList[index])),
                            itemCount: activityList.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 24)))
                  ])))),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
