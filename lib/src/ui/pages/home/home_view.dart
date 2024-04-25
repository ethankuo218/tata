import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tata/src/ui/pages/activity-list/activity_list_view.dart';
import 'package:tata/src/ui/pages/chat-room-list/chat_room_list_view.dart';
import 'package:tata/src/ui/pages/chat-room-list/components/chat_room_category_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tata/src/ui/pages/my-chat-room/my_chat_room_view.dart';
import 'package:tata/src/ui/pages/realtime_pair/realtime_pair_view.dart';
import 'package:tata/src/ui/pages/settings/settings_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ChatRoomListView(),
    const MyChatRoomView(),
    const Text('Realtime Chat Button'),
    const ActivityListView(),
    const Text('Settings Button'),
  ];

  static const categoryList = [
    'All',
    'Relation',
    'Work',
    'Interest',
    'Sport',
    'Chat',
    'School'
  ];

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
        case 1:
        case 3:
          _selectedIndex = index;
          break;
        case 2:
          context.push(RealtimePairView.routeName);
          break;
        case 4:
          context.push(SettingsView.routeName);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            bottom: _selectedIndex == 0
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(45),
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategoryIndex = index;
                            });
                          },
                          child: ChatRoomCategoryTile(
                              title: categoryList[index],
                              isSelected: _selectedCategoryIndex == index),
                        ),
                        itemCount: categoryList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(width: 10),
                      ),
                    ),
                  )
                : null),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.black,
            labelTextStyle: MaterialStateProperty.resolveWith(
              (states) => TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            iconTheme: MaterialStateProperty.resolveWith(
              (states) => IconThemeData(
                color: Colors.white.withOpacity(0.7),
                size: 22,
              ),
            ),
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
            indicatorColor: Colors.transparent,
          ),
          child: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              destinations: <Widget>[
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    color: _selectedIndex == 0
                        ? Colors.purple.withOpacity(0.8)
                        : Colors.white.withOpacity(0.3),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.comment,
                    color: _selectedIndex == 1
                        ? Colors.purple.withOpacity(0.8)
                        : Colors.white.withOpacity(0.3),
                  ),
                  label: '',
                ),
                GestureDetector(
                  onTap: () {
                    context.push(RealtimePairView.routeName);
                  },
                  child: Stack(children: [
                    Positioned.fill(
                      top: -25,
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.8),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.purple.withOpacity(0.4),
                                    spreadRadius: 6,
                                    blurRadius: 6,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.userGroup,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ))),
                    )
                  ]),
                ),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.hourglassStart,
                    color: _selectedIndex == 3
                        ? Colors.purple.withOpacity(0.8)
                        : Colors.white.withOpacity(0.3),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.gear,
                    color: _selectedIndex == 4
                        ? Colors.purple.withOpacity(0.8)
                        : Colors.white.withOpacity(0.3),
                  ),
                  label: '',
                ),
              ]),
        ));
  }
}
