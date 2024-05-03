import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/repositories/chat_room_repository.dart';
import 'package:tata/src/core/state/pair_state.dart';
import 'package:tata/src/core/models/chat_room.dart';

part 'realtime_pair_provider.g.dart';

@riverpod
class RealtimePair extends _$RealtimePair {
  String? _createdChatRoomId;

  @override
  PairState build() {
    state = const PairState.initial();
    _dispose();
    return const PairState.initial();
  }

  void _dispose() {
    ref.onDispose(() async {
      await cancelPairing();
    });
  }

  //Reset State
  void reset() {
    state = const PairState.initial();
  }

  // Start Pairing
  Future<void> startPairing() async {
    state = const PairState.loading();

    try {
      // find a realtime chat room with members less than 2
      final List<ChatRoom> chatRoomList =
          await ref.read(chatRoomRepositoryProvider).getRealtimeChatRoomList();

      for (var chatRoom in chatRoomList) {
        if (chatRoom.memberCount < 2 &&
            chatRoom.hostId != FirebaseAuth.instance.currentUser!.uid) {
          ref.read(chatRoomRepositoryProvider).joinChatRoom(chatRoom.id);

          state = PairState.success(chatRoomId: _createdChatRoomId!);
          return;
        }
      }

      return waitForPaired();
    } catch (e) {
      state = const PairState.failed(error: 'Unknown error');
    }
  }

  Future<void> waitForPaired() async {
    try {
      // create a new realtime chat room and wait for the other user to join
      _createdChatRoomId =
          await ref.read(chatRoomRepositoryProvider).createRealtimeChatRoom();

      // check every 3 secs for 10 times
      for (var i = 0; i < 10; i++) {
        await Future.delayed(const Duration(seconds: 3));

        if (state != const PairState.loading()) {
          break;
        }

        final ChatRoom chatRoomInfo = await ref
            .read(chatRoomRepositoryProvider)
            .getChatRoomInfo(_createdChatRoomId!);

        final bool isPaired = chatRoomInfo.memberCount > 1;

        if (isPaired) {
          state = PairState.success(chatRoomId: _createdChatRoomId!);
          _createdChatRoomId = null;
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
      if (_createdChatRoomId != null) {
        await ref
            .read(chatRoomRepositoryProvider)
            .deleteChatRoom(_createdChatRoomId!);

        _createdChatRoomId = null;
        state = const PairState.initial();
      }
    } catch (e) {
      print(e);
    }
  }
}

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