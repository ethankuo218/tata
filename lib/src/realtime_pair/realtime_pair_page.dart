import 'package:go_router/go_router.dart';
import 'package:tata/src/chat-room/chat_room_view.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/services/chat.service.dart';
import 'package:flutter/material.dart';

class RealtimePairPage extends StatefulWidget {
  const RealtimePairPage({super.key});

  static const routeName = '/realtime-pair';

  @override
  State<StatefulWidget> createState() => _RealtimePairPageState();
}

class _RealtimePairPageState extends State<RealtimePairPage> {
  bool isPairing = false;

  @override
  void initState() {
    super.initState();

    _pair();
  }

  @override
  void dispose() {
    super.dispose();

    // cancel pair ?
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isPairing == true
            ? const Text('Pairing...', style: TextStyle(color: Colors.white))
            : const Text('Pairing Failed',
                style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _pair() {
    setState(() {
      isPairing = true;
    });

    ChatService().realtimePair().then((chatRoomInfo) {
      setState(() {
        isPairing = false;
      });

      if (chatRoomInfo != null) {
        context.push(ChatRoomView.routeName, extra: chatRoomInfo);
      }
    });
  }
}
