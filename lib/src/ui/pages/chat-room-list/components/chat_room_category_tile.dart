import 'package:flutter/material.dart';

class ChatRoomCategoryTile extends StatelessWidget {
  final String title;
  final bool isSelected;

  const ChatRoomCategoryTile(
      {super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.purple.withOpacity(0.8)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
