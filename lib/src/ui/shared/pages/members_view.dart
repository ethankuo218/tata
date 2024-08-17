import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/providers/shared/members_view_provider.dart';
import 'package:tata/src/utils/avatar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MembersView extends ConsumerWidget {
  const MembersView(
      {super.key, required this.repository, required this.roomId});

  final String repository;
  final String roomId;

  static const routeName = 'members';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MembersViewProvider provider =
        membersViewProvider(repository: repository, roomId: roomId);

    return ref.watch(provider).when(
          data: (memberList) {
            final MemberInfo host =
                memberList.firstWhere((element) => element.role == 'host');
            final bool isHost =
                host.uid == FirebaseAuth.instance.currentUser!.uid;

            memberList = [
              host,
              ...memberList.filter((element) => element.uid != host.uid)
            ];

            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 12, 13, 32),
                title: Text(AppLocalizations.of(context)!.common_room_member),
                centerTitle: true,
                titleSpacing: 0,
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 12, 13, 32),
                      Color.fromARGB(255, 26, 0, 58)
                    ],
                  ),
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final bool isRemovable = memberList[index].role == 'member';

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
                                        .removeMember(memberList[index].uid),
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
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
        );
  }

  Widget _buildMemberItem(MemberInfo member) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
              radius: 20,
              backgroundImage:
                  Image.asset(Avatar.getAvatarImage(member.avatar)).image),
          const SizedBox(width: 16),
          Text(
            member.name,
            style: const TextStyle(
              height: 6 / 4,
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          if (member.role == 'host')
            const Text('Host',
                style: TextStyle(
                    height: 6 / 4,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
