import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tata/src/utils/avatar.dart';

class ChooseAvatarView extends StatefulWidget {
  const ChooseAvatarView({super.key, required this.onSelected});

  final Function(int) onSelected;

  @override
  State<ChooseAvatarView> createState() => _ChooseAvatarViewState();
}

class _ChooseAvatarViewState extends State<ChooseAvatarView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text('選擇人物頭像',
              style: TextStyle(color: Colors.white, fontSize: 32)),
          const SizedBox(height: 20),
          const Text(
            '頭貼將會在聊天室中出現，挑選一個最符合您形象的人物吧！',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = currentIndex - 1;
                    if (currentIndex < 0) {
                      currentIndex = AvatarKey.values.length - 1;
                    }

                    widget.onSelected(currentIndex);
                  });
                },
              ),
              CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      Avatar.getAvatarImage(AvatarKey.values[currentIndex]))),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = currentIndex + 1;
                    if (currentIndex >= AvatarKey.values.length) {
                      currentIndex = 0;
                    }

                    widget.onSelected(currentIndex);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
