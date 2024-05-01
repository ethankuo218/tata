import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tata/src/core/providers/members_provider.dart';
import 'package:tata/src/ui/avatar.dart';
import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/core/models/chat_room.dart';

class MembersView extends ConsumerWidget {
  final ChatRoom chatRoomInfo;
  const MembersView({super.key, required this.chatRoomInfo});

  static const routeName = 'members';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isHost =
        chatRoomInfo.hostId == FirebaseAuth.instance.currentUser!.uid;
    final MembersProvider provider = membersProvider(chatRoomInfo.members);

    return ref.watch(provider).when(
          data: (memberList) => Scaffold(
            appBar: AppBar(
              title: const Text('Members'),
            ),
            body: ListView.separated(
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                final bool isRemovable =
                    memberList[index].uid != chatRoomInfo.hostId;

                return isHost && isRemovable
                    ? Slidable(
                        endActionPane: ActionPane(
                            extentRatio: 0.25,
                            dragDismissible: false,
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) => ref
                                    .read(provider.notifier)
                                    .removeMember(
                                        chatRoomInfo.id, memberList[index].uid),
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
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
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
          if (chatRoomInfo.hostId == member.uid)
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
