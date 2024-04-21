import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tata/src/core/avatar.dart';
import 'package:tata/src/models/app_user_info.dart';
import 'package:tata/src/models/chat_room.dart';
import 'package:tata/src/services/chat.service.dart';
import 'package:tata/src/services/user.service.dart';

class MembersPage extends StatefulWidget {
  final ChatRoom chatRoomInfo;
  const MembersPage({super.key, required this.chatRoomInfo});

  static const routeName = 'members';

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  late bool isHost = false;
  late List<AppUserInfo> memberList = [];

  @override
  void initState() {
    super.initState();

    isHost =
        widget.chatRoomInfo.hostId == FirebaseAuth.instance.currentUser!.uid;

    UserService().getUserInfoList(widget.chatRoomInfo.members).then((value) {
      setState(() {
        memberList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          final bool isRemovable =
              memberList[index].uid != widget.chatRoomInfo.hostId;

          return isHost && isRemovable
              ? Slidable(
                  endActionPane: ActionPane(
                      extentRatio: 0.25,
                      dragDismissible: false,
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            ChatService()
                                .removeMember(widget.chatRoomInfo.id,
                                    memberList[index].uid)
                                .then((value) => setState(() {
                                      memberList.removeAt(index);
                                    }));
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ]),
                  child: _buildMemberItem(memberList[index]))
              : _buildMemberItem(memberList[index]);
        },
        itemCount: memberList.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 10),
      ),
    );
  }

  Widget _buildMemberItem(AppUserInfo member) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
              radius: 30,
              backgroundImage:
                  Image.asset(Avatar.getAvatarImage(Avatar.getRandomAvatar()))
                      .image),
          const SizedBox(width: 10),
          Text(
            member.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (widget.chatRoomInfo.hostId == member.uid)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text('Host',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            )
        ],
      ),
    );
  }
}
