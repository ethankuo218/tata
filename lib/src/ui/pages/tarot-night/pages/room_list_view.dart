import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/core/providers/pages/tarot-night/room_list_view_provider.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/draw_role_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/room_view.dart';
import 'package:tata/src/ui/pages/tarot-night/widgets/room_detail_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TarotNightRoomListView extends ConsumerStatefulWidget {
  const TarotNightRoomListView({super.key});

  static const routeName = '/tarot-night/room-list';

  static const List<TarotNightRoomTheme> themeList = <TarotNightRoomTheme>[
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

class _TarotNightRoomListViewState extends ConsumerState<TarotNightRoomListView>
    with RouteAware {
  final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    ref.read(tarotNightRoomListViewProvider.notifier).reload();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(tarotNightRoomListViewProvider).when(
          data: (listMap) => DefaultTabController(
            initialIndex: TarotNightRoomTheme.all.value,
            length: TarotNightRoomListView.themeList.length,
            child: Scaffold(
                appBar: AppBar(
                    title: Text(AppLocalizations.of(context)!
                        .activity_lobby_activity_title)),
                body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 12, 13, 32),
                    Color.fromARGB(255, 26, 0, 58)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 241, 198, 255)
                                    .withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0))),
                            child: TabBar(
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              labelColor:
                                  const Color.fromARGB(255, 241, 198, 255),
                              unselectedLabelColor: Colors.white,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: const Color.fromARGB(255, 241, 198, 255)
                                    .withOpacity(0.2),
                              ),
                              indicatorColor: Colors.white,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: const TextStyle(
                                  height: 1.5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              dividerColor: Colors.transparent,
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              tabs: TarotNightRoomListView.themeList
                                  .map((e) => ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          maxHeight: 32,
                                          minHeight: 32,
                                          minWidth: 40),
                                      child: Tab(
                                          text: TarotNightRoomTheme.toText(
                                              context, e))))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                        opacity: 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/star_4.svg',
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                                AppLocalizations.of(context)!
                                    .activity_room_list_activity_join_description,
                                style: const TextStyle(
                                    height: 4 / 3,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                            const SizedBox(width: 8),
                            SvgPicture.asset(
                              'assets/images/star_4.svg',
                              width: 16,
                              height: 16,
                            ),
                          ],
                        )),
                    const SizedBox(height: 8),
                    Expanded(
                        child: TabBarView(children: [
                      _buildListView(listMap[TarotNightRoomTheme.all]),
                      _buildListView(listMap[TarotNightRoomTheme.work]),
                      _buildListView(listMap[TarotNightRoomTheme.relation]),
                      _buildListView(listMap[TarotNightRoomTheme.family]),
                      _buildListView(listMap[TarotNightRoomTheme.friend]),
                    ]))
                  ]),
                )),
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
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 168.5 / 160,
            children: rooms != null
                ? rooms
                    .map((room) => GestureDetector(
                        onTap: () async {
                          if (!room.isMember) {
                            showTarotNightRoomDetailDialog(context,
                                roomInfo: room, onClosed: (_) {
                              if (_ == true) {
                                context.push(TarotNightDrawRoleView.routeName,
                                    extra: room.id);
                              }
                            });
                          } else {
                            context.push(TarotNightRoomView.routeName,
                                extra: room.id);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 241, 198, 255)
                                  .withOpacity(0.1),
                              border: GradientBoxBorder(
                                  gradient: LinearGradient(
                                    colors: room.isMember
                                        ? [
                                            const Color.fromARGB(
                                                    255, 223, 130, 255)
                                                .withOpacity(0.8),
                                            const Color.fromARGB(
                                                    255, 241, 198, 255)
                                                .withOpacity(0.2),
                                            const Color.fromARGB(
                                                    255, 223, 130, 255)
                                                .withOpacity(0.8),
                                            const Color.fromARGB(
                                                    255, 241, 198, 255)
                                                .withOpacity(0.2)
                                          ]
                                        : [
                                            const Color.fromARGB(
                                                    255, 241, 198, 255)
                                                .withOpacity(0.3),
                                            const Color.fromARGB(
                                                    255, 241, 198, 255)
                                                .withOpacity(0.3)
                                          ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SvgPicture.asset('assets/images/star_3.svg',
                                  width: 20,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                      room.isMember
                                          ? const Color.fromARGB(
                                              255, 223, 130, 255)
                                          : Colors.white.withOpacity(0.5),
                                      BlendMode.srcIn)),
                              const SizedBox(height: 8),
                              Text(room.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              const SizedBox(height: 8),
                              Text(room.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 4 / 3,
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 12)),
                              const Spacer(),
                              const SizedBox(height: 8),
                              Container(
                                constraints: const BoxConstraints(
                                    minWidth: 60, maxHeight: 22),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: room.isMember
                                        ? const Color.fromARGB(
                                            255, 241, 198, 255)
                                        : const Color.fromARGB(
                                                255, 241, 198, 255)
                                            .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                    room.isMember
                                        ? Role.getRoleName(context, room.role!)
                                        : '?',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        height: 1.0,
                                        color: Color.fromARGB(255, 12, 13, 32),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        )))
                    .toList()
                : []));
  }
}
