import 'package:flutter/material.dart';

class ChatRoomCategoryTile extends StatelessWidget {
  final String title;
  final String? imageUrl;
  const ChatRoomCategoryTile({super.key, required this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            // image: const DecorationImage(
            //     image: AssetImage('assets/images/the_fool.jpeg'),
            //     fit: BoxFit.cover,
            //     alignment: Alignment.topCenter,
            //     opacity: 0.8),
            color: const Color.fromARGB(255, 225, 225, 225),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        InkWell(
          splashColor: Colors.white,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () => {},
          child: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 201, 201, 201).withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
