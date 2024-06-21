import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 13, 32),
        automaticallyImplyLeading: false,
        toolbarHeight: 33,
        title: const Text('TATA',
            style: TextStyle(
              color: Color.fromARGB(255, 223, 130, 255),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )),
        titleSpacing: 20,
        centerTitle: false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
