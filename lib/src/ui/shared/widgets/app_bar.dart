import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        centerTitle: false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
