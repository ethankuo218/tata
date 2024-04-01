import 'package:flutter/material.dart';
import 'package:tata/src/chat-room-list/chat_room_list_page.dart';
import 'package:tata/src/chat-room-list/components/chat_room_category_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tata/src/chat-room-list/create_chat_room_dialog.dart';
import 'package:tata/src/services/chat_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ChatRoomListPage(),
    Text(
      'Index 1: Chat Rooms',
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 2: Add Chat Room',
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 3: Activity',
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 4: User',
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    ),
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
      if (index != 2) {
        _selectedIndex = index;
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
            // shape: Border(
            //     bottom: BorderSide(
            //   color: Colors.white.withOpacity(0.3),
            //   width: 0,
            // )),
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
                // fontWeight: FontWeight.bold,
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
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.comment,
                    color: _selectedIndex == 1
                        ? Colors.purple.withOpacity(0.8)
                        : Colors.white.withOpacity(0.3),
                  ),
                  label: 'Chat Rooms',
                ),
                GestureDetector(
                  onTap: () {
                    // navigate to create chat room page
                    createChatRoomDialog(context, onClosed: (_) {
                      if (_ == null) {
                        return;
                      }
                      ChatService().createChatRoom(_["title"], _["description"],
                          _["category"], _["backgroundImage"], _["limit"]);
                    });
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
                                  FontAwesomeIcons.plus,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ))),
                    )
                  ]),
                ),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.starOfDavid,
                    color: _selectedIndex == 3
                        ? Colors.purple.withOpacity(0.8)
                        : Colors.white.withOpacity(0.3),
                  ),
                  label: 'Activity',
                ),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                    color: _selectedIndex == 4
                        ? Colors.purple.withOpacity(0.8)
                        : Colors.white.withOpacity(0.3),
                  ),
                  label: 'User',
                ),
              ]),
        ));
  }
}
