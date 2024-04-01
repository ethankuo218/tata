import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tata/src/home/home_page.dart';
import 'package:tata/src/login/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  static const String routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginPage();
          }

          return const HomePage();
        },
      ),
    );
  }
}
