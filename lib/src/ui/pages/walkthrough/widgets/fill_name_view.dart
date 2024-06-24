import 'package:flutter/material.dart';

class FillNameView extends StatelessWidget {
  const FillNameView({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Text('輸入您的名稱',
              style: TextStyle(color: Colors.white, fontSize: 32)),
          const SizedBox(height: 20),
          const Text(
            '您會以這個名稱穿梭在聊天室中，快來創造獨特的名稱，成為焦點！',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            decoration: InputDecoration(
              hintText: '輸入您的名稱',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
          )
        ],
      ),
    );
  }
}
