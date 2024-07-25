import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';
import 'package:tata/src/core/services/snackbar_service.dart';
import 'package:tata/src/ui/pages/chat-room-list/chat_room_list_view.dart';
import 'package:tata/src/ui/pages/chat-room/chat_room_view.dart';
import 'package:tata/src/ui/pages/home/widgets/create_chat_room_bottom_sheet.dart';
import 'package:tata/src/ui/pages/my-chat-room/my_chat_room_view.dart';
import 'package:tata/src/ui/pages/settings/settings_view.dart';
import 'package:tata/src/ui/pages/tarot-night/pages/lobby_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ChatRoomListView(),
    const MyChatRoomView(),
    const Text('Realtime Chat Button'),
    const Text('Tarot Night Button'),
    const Text('Settings Button'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
        case 1:
          _selectedIndex = index;
          break;
        case 2:
          break;
        case 3:
          context.push(TarotNightLobbyView.routeName);
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
            backgroundColor: const Color.fromARGB(255, 12, 13, 32),
            centerTitle: false,
            titleSpacing: 0,
            toolbarHeight: 0),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButton: GestureDetector(
            onTap: () => {
                  showCreateChatRoomBottomSheet(context,
                      mode: CreateChatRoomBottomSheetMode.create,
                      onClosed: (_) {
                    if (_ == null) {
                      return;
                    }

                    ref
                        .read(chatRoomRepositoryProvider)
                        .createChatRoom(
                            title: _["title"],
                            description: _["description"],
                            category: _["category"],
                            limit: _["limit"] ?? 2)
                        .then((value) {
                      context.push(ChatRoomView.routeName, extra: value);
                    }).catchError((e) {
                      SnackbarService().showSnackBar(
                          context: context, message: e.toString());
                    });
                  })
                },
            child: Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment(-1, -1),
                        end: Alignment(0.7, 0.7),
                        colors: [
                          Color.fromARGB(255, 12, 13, 32),
                          Color.fromARGB(255, 93, 102, 65),
                          Color.fromARGB(255, 12, 13, 32)
                        ]),
                    shape: BoxShape.circle,
                    border: GradientBoxBorder(
                        gradient: LinearGradient(
                            begin: const Alignment(-1, -1),
                            end: const Alignment(0.7, 0.7),
                            colors: [
                              const Color.fromARGB(255, 215, 255, 3),
                              const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.8),
                              const Color.fromARGB(255, 215, 255, 3)
                            ]),
                        width: 3),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 215, 255, 53)
                              .withOpacity(0.5),
                          blurRadius: 30,
                          offset: const Offset(0, 0))
                    ]),
                child: const FaIcon(FontAwesomeIcons.plus,
                    color: Color.fromARGB(255, 215, 255, 3)))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: const Color.fromARGB(255, 12, 13, 32),
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
                        ? const Color.fromARGB(255, 255, 195, 79)
                        : const Color.fromARGB(255, 161, 160, 161),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.solidComment,
                    color: _selectedIndex == 1
                        ? const Color.fromARGB(255, 255, 195, 79)
                        : const Color.fromARGB(255, 161, 160, 161),
                  ),
                  label: '',
                ),
                const SizedBox(),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.hourglassStart,
                    color: _selectedIndex == 3
                        ? const Color.fromARGB(255, 255, 195, 79)
                        : const Color.fromARGB(255, 161, 160, 161),
                  ),
                  label: '',
                ),
                NavigationDestination(
                  icon: FaIcon(
                    FontAwesomeIcons.solidUser,
                    color: _selectedIndex == 4
                        ? const Color.fromARGB(255, 255, 195, 79)
                        : const Color.fromARGB(255, 161, 160, 161),
                  ),
                  label: '',
                ),
              ]),
        ));
  }
}
