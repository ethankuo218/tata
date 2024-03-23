import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../chat-room-list/chat_room_list_page.dart';
import '../../login/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatRoomListPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
