import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/providers/tarot_night_room_list_view_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/draw_role_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_view.dart';

class TarotNightRoomListView extends ConsumerStatefulWidget {
  const TarotNightRoomListView({super.key});

  static const routeName = '/tarot-night/room-list';

  static const List<TarotNightRoomTheme> themeList = <TarotNightRoomTheme>[
    TarotNightRoomTheme.myRoom,
    TarotNightRoomTheme.all,
    TarotNightRoomTheme.work,
    TarotNightRoomTheme.relation,
    TarotNightRoomTheme.family,
    TarotNightRoomTheme.friend,
  ];

  @override
  ConsumerState<TarotNightRoomListView> createState() =>
      _TarotNightRoomListViewState();
}

class _TarotNightRoomListViewState
    extends ConsumerState<TarotNightRoomListView> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(tarotNightRoomListViewProvider).when(
          data: (listMap) => DefaultTabController(
            initialIndex: TarotNightRoomTheme.all.value,
            length: TarotNightRoomListView.themeList.length,
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 33,
                  title: const Text('TATA',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MedievalSharp',
                      )),
                  titleSpacing: 20,
                  centerTitle: false,
                  bottom: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                    tabs: TarotNightRoomListView.themeList
                        .map((e) => ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 58),
                            child: Tab(
                                text: TarotNightRoomTheme.toText(e)
                                    .toUpperCase())))
                        .toList(),
                  ),
                ),
                body: TabBarView(children: [
                  _buildListView(listMap[TarotNightRoomTheme.myRoom]),
                  _buildListView(listMap[TarotNightRoomTheme.all]),
                  _buildListView(listMap[TarotNightRoomTheme.work]),
                  _buildListView(listMap[TarotNightRoomTheme.relation]),
                  _buildListView(listMap[TarotNightRoomTheme.family]),
                  _buildListView(listMap[TarotNightRoomTheme.friend]),
                ])),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        );
  }

  Widget _buildListView(List<TarotNightRoom>? rooms) {
    return RefreshIndicator(
        onRefresh: ref.read(tarotNightRoomListViewProvider.notifier).reload,
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            childAspectRatio: 0.85,
            padding: const EdgeInsets.all(15),
            children: rooms != null
                ? rooms
                    .map((room) => GestureDetector(
                        onTap: () async {
                          final bool isJoined = ref
                              .read(tarotNightRoomListViewProvider.notifier)
                              .isJoinedRoom(room.id);

                          if (!isJoined) {
                            // TODO: if not, show the detail dialog
                            // navigate to draw role view after confirm to join the room
                            context.push(TarotNightDrawRoleView.routeName,
                                extra: room.id);
                            return;
                          } else {
                            context.push(TarotNightRoomView.routeName,
                                extra: room.id);
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          116, 232, 167, 72),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.asset(
                                'assets/images/star.png',
                                opacity: const AlwaysStoppedAnimation(0.3),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Text(room.title,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: const Center(
                                        child: Text('查看問題',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 137, 118, 82),
                                                fontSize: 16)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )))
                    .toList()
                : []));
  }
}
