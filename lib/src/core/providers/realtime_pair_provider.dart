import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tata/src/core/state/pair_state.dart';
import 'package:tata/src/core/models/chat_room.dart';
import 'package:tata/src/ui/tarot.dart';

class PairStateNotifier extends StateNotifier<PairState> {
  PairStateNotifier(this._firebaseAuth, this._fireStore)
      : super(const PairState.initial());

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;
  String? createdChatRoomId;

  @override
  void dispose() {
    super.dispose();
    cancelPairing();
  }

  //Reset State
  void reset() {
    state = const PairState.initial();
  }

  // Start Pairing
  Future<void> startPairing() async {
    state = const PairState.loading();

    try {
      final String currentUserId = _firebaseAuth.currentUser!.uid;

      // find a realtime chat room with members less than 2
      final QuerySnapshot<Map<String, dynamic>> chatRoomSnapshot =
          await _fireStore
              .collection('chat_rooms')
              .where('type', isEqualTo: ChatRoomType.realtime.value)
              .get();

      for (var element in chatRoomSnapshot.docs) {
        final ChatRoom chatRoom = ChatRoom.fromMap(element.data());

        if (chatRoom.members.length < 2) {
          await _fireStore.collection('chat_rooms').doc(chatRoom.id).update({
            'members': FieldValue.arrayUnion([currentUserId])
          });

          state = PairState.success(chatRoomInfo: chatRoom);
          return;
        }
      }

      return waitForPaired();
    } catch (e) {
      state = const PairState.failed(error: 'Unknown error');
    }
  }

  Future<void> waitForPaired() async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;

    try {
      // create a new realtime chat room and wait for the other user
      final DocumentReference newChatRoomDoc =
          _fireStore.collection('chat_rooms').doc();

      final ChatRoom newChatRoom = ChatRoom(
          id: newChatRoomDoc.id,
          type: ChatRoomType.realtime,
          title: '',
          description: '',
          category: '',
          backgroundImage: TarotCard.fool,
          limit: 2,
          members: [currentUserId],
          createTime: Timestamp.now());

      newChatRoomDoc.set(newChatRoom.toMap());

      createdChatRoomId = newChatRoomDoc.id;

      // check every 3 secs for 10 times
      for (var i = 0; i < 10; i++) {
        await Future.delayed(const Duration(seconds: 3));

        final QuerySnapshot<Map<String, dynamic>> chatRoomSnapshot =
            await _fireStore
                .collection('chat_rooms')
                .where('id', isEqualTo: newChatRoomDoc.id)
                .get();

        final ChatRoom chatRoomInfo =
            ChatRoom.fromMap(chatRoomSnapshot.docs[0].data());

        final bool isPaired = chatRoomInfo.members.length > 1;

        if (isPaired) {
          state = PairState.success(chatRoomInfo: chatRoomInfo);
          createdChatRoomId = null;
          return;
        }
      }

      if (state == const PairState.loading()) {
        cancelPairing();
      }
    } catch (e) {}
  }

  // Cancel Pairing
  Future<void> cancelPairing() async {
    // If success, remove the chat room
    try {
      if (createdChatRoomId != null) {
        await _fireStore
            .collection('chat_rooms')
            .doc(createdChatRoomId)
            .delete();

        createdChatRoomId = null;
        state = const PairState.initial();
      }
    } catch (e) {
      print(e);
    }
  }
}

final realtimePairStateProvider =
    StateNotifierProvider.autoDispose<PairStateNotifier, PairState>((ref) =>
        PairStateNotifier(FirebaseAuth.instance, FirebaseFirestore.instance));

// Join A Chat Room: 
// Get Chat Room List (Select Id) 
// -> Join by id 
// -> Get Messages Stream by id
// Send message | Leave chat room

// Create A Chat Room:
// Create a new chat room (Generate Id) 
// -> Join by id 
// -> Get Messages Stream by id
// Send message | Leave chat room

// Realtime Pair:
// Get the chat room list with type: realtime
// Found → Add user to member list & navigate to chat room.
// Not found →  Create a new chat room & waiting 
// Check every 3 secs → 10 times → stop
// Chat room have member > 1 → navigate to chat room