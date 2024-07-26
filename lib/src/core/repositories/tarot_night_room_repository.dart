import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/core/models/member.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:tata/src/core/models/tarot_night_message.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';
import 'package:tata/src/utils/avatar.dart';

part 'tarot_night_room_repository.g.dart';

class TarotNightRoomRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Get Tarot Night Room List
  Future<List<TarotNightRoom>> getLobbyRoomList() async {
    // Ensure there is a currently authenticated user
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return []; // Return an empty list if there is no user logged in
    }
    final String currentUserId = currentUser.uid;
    final DateTime now = DateTime.now();
    final DateTime startTime = DateTime(now.year, now.month, now.day, 8);
    final DateTime endTime =
        DateTime(now.year, now.month, now.day, 1).add(const Duration(days: 1));

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
        .collection('tarot_night_rooms')
        .where('create_time', isGreaterThan: startTime)
        .where('create_time', isLessThan: endTime)
        .orderBy('create_time')
        .get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    // Start a collection group query on 'members' subcollection across all 'tarot_night_rooms'
    final QuerySnapshot<Map<String, dynamic>> memberDocs = await _fireStore
        .collectionGroup('participants')
        .where('uid', isEqualTo: currentUserId)
        .where('role', isNotEqualTo: 'host')
        .get();

    List<TarotNightRoom> roomList = querySnapshot.docs
        .map((chatRoom) => TarotNightRoom.fromJson(chatRoom.data()))
        .toList();

    for (var room in roomList) {
      final DocumentReference<Map<String, dynamic>> roomRef =
          _fireStore.collection('tarot_night_rooms').doc(room.id);
      final DocumentSnapshot<Map<String, dynamic>> roomDoc =
          await roomRef.get();
      final Timestamp createTime = roomDoc.data()!['create_time'] as Timestamp;
      if (createTime.toDate().isAfter(startTime) &&
          createTime.toDate().isBefore(endTime)) {
        room.isMember = memberDocs.docs.any(
            (memberDoc) => memberDoc.reference.parent.parent!.id == room.id);
        room.role = room.isMember
            ? memberDocs.docs
                .firstWhere((memberDoc) =>
                    memberDoc.reference.parent.parent!.id == room.id)
                .data()['role']
            : null;
      }
    }

    return roomList;
  }

  // Get Joined Rooms
  Future<List<TarotNightRoom>> getJoinedRooms() async {
    // Ensure there is a currently authenticated user
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return []; // Return an empty list if there is no user logged in
    }
    final String currentUserId = currentUser.uid;

    // Get the current date and time
    final DateTime now = DateTime.now();

    // Calculate the start time (today at 11 PM)
    final DateTime startTime = DateTime(now.year, now.month, now.day, 8);

    // Calculate the end time (tomorrow at 1 AM)
    final DateTime endTime =
        DateTime(now.year, now.month, now.day, 1).add(const Duration(days: 1));

    try {
      // Start a collection group query on 'members' subcollection across all 'tarot_night_rooms'
      final QuerySnapshot<Map<String, dynamic>> memberDocs = await _fireStore
          .collectionGroup('participants')
          .where('uid', isEqualTo: currentUserId)
          .where('role', isNotEqualTo: 'host')
          .get();

      // Filter the chat rooms based on the create_time constraints
      List<TarotNightRoom> joinedRooms = [];
      for (var memberDoc in memberDocs.docs) {
        // Reference to the parent chat room document
        DocumentReference<Map<String, dynamic>> roomRef =
            memberDoc.reference.parent.parent!;
        DocumentSnapshot<Map<String, dynamic>> roomDoc = await roomRef.get();
        Timestamp createTime = roomDoc.data()!['create_time'] as Timestamp;
        if (createTime.toDate().isAfter(startTime) &&
            createTime.toDate().isBefore(endTime)) {
          joinedRooms.add(TarotNightRoom.fromJson({
            ...roomDoc.data()!,
            'is_member': true,
            'role': memberDoc.data()['role'],
          }));
        }
      }

      return joinedRooms;
    } catch (e) {
      // Handle errors or exceptions by logging or other means
      print('Error fetching joined rooms: $e');
      return []; // Return an empty list in case of error
    }
  }

  // Get Host Room Info
  Future<TarotNightRoom?> getHostRoomInfo() async {
    final DateTime now = DateTime.now();
    final DateTime startTime = DateTime(now.year, now.month, now.day, 8);
    final DateTime endTime =
        DateTime(now.year, now.month, now.day, 1).add(const Duration(days: 1));

    final String currentUserId = _firebaseAuth.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
        .collection('tarot_night_rooms')
        .where('host_id', isEqualTo: currentUserId)
        .where('create_time', isGreaterThan: startTime)
        .where('create_time', isLessThan: endTime)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    TarotNightRoom room =
        TarotNightRoom.fromJson(querySnapshot.docs.first.data());

    return room;
  }

  // Send Message
  Future<void> sendMessage(
      {required MemberInfo memberInfo,
      required String chatRoomId,
      required String content,
      TarotNightMessageType? type}) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    TarotNightMessage newMessage = TarotNightMessage(
      senderId: currentUserId,
      name: memberInfo.name,
      avatar: memberInfo.avatar,
      content: content,
      timestamp: timestamp,
      type: type ?? TarotNightMessageType.normal,
      role: memberInfo.role,
      readBy: [currentUserId],
    );

    await _fireStore
        .collection('tarot_night_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toJson());

    await _fireStore.collection('tarot_night_rooms').doc(chatRoomId).update({
      'latest_message': newMessage.toJson(),
    });
  }

  // Get Messages
  Stream<List<TarotNightMessage>> getMessages(String roomId) {
    return _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<TarotNightMessage> messages = querySnapshot.docs
          .map((message) => TarotNightMessage.fromJson(message.data()))
          .toList();

      return messages.isEmpty ? <TarotNightMessage>[] : messages;
    });
  }

  // Mark as Read
  Future<void> markAsRead({required String roomId, required String memberId}) {
    return _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('messages')
        .where('sender_id', isNotEqualTo: memberId)
        .get()
        .then((querySnapshot) {
      for (var message in querySnapshot.docs) {
        message.reference.update({
          'read_by': FieldValue.arrayUnion([memberId]),
        });
      }
    });
  }

  // Create a new room
  Future<TarotNightRoom> createRoom({
    required String title,
    required String description,
    required TarotNightRoomTheme theme,
  }) async {
    final DocumentReference newRoomDoc =
        _fireStore.collection('tarot_night_rooms').doc();

    final TarotNightRoom newRoom = TarotNightRoom(
        id: newRoomDoc.id,
        theme: theme,
        title: title,
        description: description,
        hostId: _firebaseAuth.currentUser!.uid,
        memberCount: 1,
        createTime: Timestamp.now());

    final userInfo = await _fireStore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    await newRoomDoc
        .set(newRoom.toJson())
        .then((value) => TarotNightRoom.fromJson(newRoom.toJson()));

    await newRoomDoc
        .collection('participants')
        .doc(_firebaseAuth.currentUser!.uid)
        .set({
      ...userInfo.data()!.cast<String, dynamic>(),
      'role': 'host',
    }).then((value) => _markAsHost());

    return newRoom;
  }

  // Get Room Info
  Future<TarotNightRoom> getRoomInfo(String roomId) async {
    final DocumentSnapshot<Map<String, dynamic>> roomDoc =
        await _fireStore.collection('tarot_night_rooms').doc(roomId).get();

    return TarotNightRoom.fromJson(roomDoc.data()!);
  }

  // Edit Room Info
  Future<void> editRoomInfo(String roomId,
      {required String theme,
      required String title,
      required description}) async {
    final DocumentReference<Map<String, dynamic>> roomDoc =
        _fireStore.collection('tarot_night_rooms').doc(roomId);

    await roomDoc.update({
      'theme': theme,
      'title': title,
      'description': description,
    });
  }

  // Join a room
  Future<void> joinRoom(
      {required String roomId, required String roleId}) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    final List<MemberInfo> members = await _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('participants')
        .get()
        .then((value) => value.docs
            .map((member) => MemberInfo.fromJson(member.data()))
            .toList());

    if (members.any((member) => member.uid == currentUserId)) {
      print('Joined');
      return;
    }

    if (members.length == 5) {
      throw Exception('Room is full');
    }

    final DocumentSnapshot<Map<String, dynamic>> userInfoSnapshot =
        await _fireStore
            .collection('users')
            .doc(_firebaseAuth.currentUser!.uid)
            .get();
    final AppUserInfo userInfo = AppUserInfo.fromJson(userInfoSnapshot.data()!);

    final DocumentSnapshot<Map<String, dynamic>> roleInfoSnapshot =
        await _fireStore.collection('roles').doc(roleId).get();
    final Role role = Role.fromJson(roleInfoSnapshot.data()!);

    int randomNumber = Random().nextInt(3);

    // add current user to chat room members
    await _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('participants')
        .doc(currentUserId)
        .set({
      ...userInfoSnapshot.data()!.cast<String, dynamic>(),
      'role': role.name,
      'quest': role.quest[randomNumber]
    });

    await _fireStore.collection('tarot_night_rooms').doc(roomId).update({
      'member_count': FieldValue.increment(1),
    });

    sendMessage(
        memberInfo: MemberInfo(
            name: 'system',
            uid: 'system',
            avatar: AvatarKey.theFool,
            birthday: 'system',
            role: 'system',
            fcmToken: 'system'),
        chatRoomId: roomId,
        content: '${userInfo.name} 加入了房間',
        type: TarotNightMessageType.system);
  }

  // Leave a chat room
  Future<void> leaveChatRoom(String roomId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    await _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('participants')
        .doc(currentUserId)
        .delete();
  }

  // Get members of a chat room
  Future<List<MemberInfo>> getMembers(String roomId) async {
    final List<MemberInfo> members = await _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('participants')
        .get()
        .then((value) => value.docs
            .map((member) => MemberInfo.fromJson(member.data()))
            .toList());

    return members;
  }

  // Get Member Info
  Future<MemberInfo> getMemberInfo(String roomId, String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> memberDoc = await _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('participants')
        .doc(uid)
        .get();

    return MemberInfo.fromJson(memberDoc.data()!);
  }

  // Remove a member from a chat room
  Future<void> removeMember(
      {required String roomId, required String memberId}) async {
    await _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('participants')
        .doc(memberId)
        .delete();
  }

  // Get Host List
  Future<List<String>> getHostList() async {
    try {
      final DateTime today = DateTime.now();
      final bool isCrossedMidnight = today.hour < 1;
      final DateTime sessionDate =
          isCrossedMidnight ? today.subtract(const Duration(days: 1)) : today;
      final String dateQuery =
          '${sessionDate.year}-${sessionDate.month.toString().padLeft(2, '0')}-${sessionDate.day.toString().padLeft(2, '0')}';

      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
          .collection('tarot_night_host_records')
          .where('date', isEqualTo: dateQuery)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      // Ensure all elements are treated as strings.
      List<String> hostList =
          querySnapshot.docs.first.data()['hosts'].toList().cast<String>();

      return hostList;
    } catch (e) {
      // Log error or handle it according to your needs
      print('Error fetching host list: $e');
      return [];
    }
  }

  // Mark as Host
  Future<void> _markAsHost() async {
    final DateTime today = DateTime.now();
    final bool isCrossedMidnight = today.hour < 1;
    final String dateQuery =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${(isCrossedMidnight ? today.day - 1 : today.day).toString().padLeft(2, '0')}';

    final String currentUserId = _firebaseAuth.currentUser!.uid;

    // get certain date's host list
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
        .collection('tarot_night_host_records')
        .where('date', isEqualTo: dateQuery)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // create new record
      await _fireStore.collection('tarot_night_host_records').add({
        'date': dateQuery,
        'hosts': [currentUserId]
      });
    } else {
      // update existing record
      final DocumentSnapshot<Map<String, dynamic>> record =
          querySnapshot.docs.first;
      final List<String> hostList =
          record.data()!['hosts'].toList().cast<String>();

      if (hostList.contains(currentUserId)) {
        return;
      }

      hostList.add(currentUserId);

      await record.reference.update({'hosts': hostList});
    }
  }

  // Update draw card result
  Future<void> updateDrawCardResult(
      {required AppUserInfo userInfo,
      required String roomId,
      required String question,
      required String card}) async {
    await _fireStore.collection('tarot_night_rooms').doc(roomId).update({
      'question': question,
      'card': card,
    });

    sendMessage(
        memberInfo: MemberInfo(
            name: userInfo.name,
            uid: userInfo.uid,
            avatar: userInfo.avatar,
            birthday: userInfo.birthday,
            role: 'host',
            fcmToken: userInfo.fcmToken),
        chatRoomId: roomId,
        content: '測驗結果出來嘍！',
        type: TarotNightMessageType.testResult);
  }

  // Update Answer
  Future<void> updateAnswer(
      {required MemberInfo memberInfo,
      required String roomId,
      required String answer}) async {
    await _fireStore.collection('tarot_night_rooms').doc(roomId).update({
      'answers': FieldValue.arrayUnion([
        TarotNightAnswer(
                uid: FirebaseAuth.instance.currentUser!.uid, answer: answer)
            .toJson()
      ])
    });

    await _fireStore
        .collection('tarot_night_rooms')
        .doc(roomId)
        .collection('participants')
        .doc(memberInfo.uid)
        .update({
      'answer': answer,
    });

    sendMessage(
        memberInfo: memberInfo,
        chatRoomId: roomId,
        content: answer,
        type: TarotNightMessageType.answer);
  }
}

@Riverpod(keepAlive: true)
TarotNightRoomRepository tarotNightRoomRepository(
        TarotNightRoomRepositoryRef ref) =>
    TarotNightRoomRepository();
