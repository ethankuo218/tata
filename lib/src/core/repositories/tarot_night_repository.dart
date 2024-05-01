import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/core/models/message.dart';
import 'package:tata/src/core/models/tarot_night_member.dart';
import 'package:tata/src/core/models/tarot_night_room.dart';

part 'tarot_night_repository.g.dart';

class TarotNightChatRoomRepository {
  static final TarotNightChatRoomRepository _instance =
      TarotNightChatRoomRepository._internal();

  factory TarotNightChatRoomRepository() {
    return _instance;
  }

  TarotNightChatRoomRepository._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;

  // Get Tarot Night Room List
  Future<List<TarotNightRoom>> getLobbyChatRoomList(bool isInitFetch) async {
    if (isInitFetch) {
      _lastDocument = null;
    }

    Query<Map<String, dynamic>> collection = _fireStore
        .collection('tarot_night_chat_rooms')
        .orderBy('create_time', descending: true);

    QuerySnapshot<Map<String, dynamic>> querySnapshot = isInitFetch
        ? await collection.limit(10).get()
        : await collection.startAfterDocument(_lastDocument!).limit(10).get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    List<TarotNightRoom> roomList = querySnapshot.docs
        .map((chatRoom) => TarotNightRoom.fromMap(chatRoom.data()))
        .toList();

    _lastDocument = querySnapshot.docs.last;

    return roomList;
  }

  // Get Joined Rooms
  Future<List<TarotNightRoom>> getJoinedRooms() async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    // Get the current date and time
    DateTime now = DateTime.now();

    // Calculate the start time (today at 11 PM)
    DateTime startTime = DateTime(now.year, now.month, now.day, 23);

    // Calculate the end time (tomorrow at 1 AM)
    DateTime endTime =
        DateTime(now.year, now.month, now.day, 1).add(const Duration(days: 1));

    // Perform the query with the calculated time boundaries
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _fireStore
        .collection('tarot_night_chat_rooms')
        .where('create_time',
            isGreaterThan: Timestamp.fromDate(startTime),
            isLessThan: Timestamp.fromDate(endTime))
        .where('members', arrayContains: currentUserId)
        .get();

    List<TarotNightRoom> joinedRooms = querySnapshot.docs
        .map((chatRoom) => TarotNightRoom.fromMap(chatRoom.data()))
        .toList();

    return joinedRooms;
  }

  // Send Message
  Future<void> sendMessage(String chatRoomId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      message: message,
      timestamp: timestamp,
    );

    await _fireStore
        .collection('tarot_night_chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    await _fireStore
        .collection('tarot_night_chat_rooms')
        .doc(chatRoomId)
        .update({
      'latest_message': newMessage.toMap(),
    });
  }

  // Get Messages
  Stream<List<Message>> getMessages(String roomId) {
    return _fireStore
        .collection('tarot_night_chat_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((message) => Message.fromMap(message.data()))
            .toList());
  }

  // Create a new room
  Future<TarotNightRoom> createRoom({
    required String title,
    required String description,
    required TarotNightRoomTheme theme,
  }) async {
    final DocumentReference newRoomDoc =
        _fireStore.collection('tarot_night_chat_rooms').doc();

    final TarotNightRoom newRoom = TarotNightRoom(
        id: newRoomDoc.id,
        theme: theme,
        title: title,
        description: description,
        hostId: _firebaseAuth.currentUser!.uid,
        memberCount: 1,
        createTime: Timestamp.now());

    final AppUserInfo userInfo = await _fireStore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((value) => AppUserInfo.fromMap(value.data()!));

    await newRoomDoc
        .set(newRoom.toMap())
        .then((value) => TarotNightRoom.fromMap(newRoom.toMap()));

    await newRoomDoc
        .collection('members')
        .doc(_firebaseAuth.currentUser!.uid)
        .set(userInfo.toMap())
        .then((value) => _markAsHost());

    return newRoom;
  }

  // Get Room Info
  Future<TarotNightRoom> getRoomInfo(String roomId) async {
    final DocumentSnapshot<Map<String, dynamic>> roomDoc =
        await _fireStore.collection('tarot_night_chat_rooms').doc(roomId).get();

    return TarotNightRoom.fromMap(roomDoc.data()!);
  }

  // Join a room
  Future<void> joinChatRoom(String roomId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    final List<TarotNightMember> members = await _fireStore
        .collection('tarot_night_chat_rooms')
        .doc(roomId)
        .collection('members')
        .get()
        .then((value) => value.docs
            .map((member) => TarotNightMember.fromMap(member.data()))
            .toList());

    if (members.any((member) => member.uid == currentUserId)) {
      return;
    }

    if (members.length == 5) {
      throw Exception('Room is full');
    }

    final AppUserInfo userInfo = await _fireStore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((value) => AppUserInfo.fromMap(value.data()!));

    // add current user to chat room members
    await _fireStore
        .collection('tarot_night_chat_rooms')
        .doc(roomId)
        .collection('members')
        .doc(currentUserId)
        .set(userInfo.toMap());
  }

  // Leave a chat room
  Future<void> leaveChatRoom(String roomId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    await _fireStore
        .collection('tarot_night_chat_rooms')
        .doc(roomId)
        .collection('members')
        .doc(currentUserId)
        .delete();
  }

  // Remove a member from a chat room
  Future<void> removeMember(
      {required String chatRoomId, required String memberId}) async {
    await _fireStore
        .collection('tarot_night_chat_rooms')
        .doc(chatRoomId)
        .collection('members')
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
}

@riverpod
TarotNightChatRoomRepository tarotNightChatRoomRepository(
        TarotNightChatRoomRepositoryRef ref) =>
    TarotNightChatRoomRepository();
