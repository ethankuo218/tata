import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/utils/avatar.dart';
import 'package:tata/src/core/models/app_user_info.dart';

part 'user_repository.g.dart';

class UserRepository {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Get User Info
  Future<AppUserInfo> getUserInfo(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await _fireStore.collection('users').doc(uid).get();

    if (!user.exists) {
      throw Exception('User not found');
    }

    return AppUserInfo.fromJson(user.data()!);
  }

  // Get User Info List
  Future<List<AppUserInfo>> getUserInfoList(List<String> uidList) async {
    QuerySnapshot<Map<String, dynamic>> userList = await _fireStore
        .collection('users')
        .where('uid', whereIn: uidList)
        .get();

    return userList.docs.map((e) => AppUserInfo.fromJson(e.data())).toList();
  }

  // Edit User Info
  Future<void> editUserInfo(
      {required String uid,
      String? name,
      String? birthday,
      AvatarKey? avatar}) async {
    if (name == null && avatar == null) {
      throw Exception('Need to provide one of the value you want to edit');
    }

    await _fireStore.collection('users').doc(uid).update({
      ...name != null ? {'name': name} : {},
      ...birthday != null ? {'birthday': birthday} : {},
      ...avatar != null ? {'avatar': avatar.value} : {},
    });
  }
}

@riverpod
UserRepository userRepository(UserRepositoryRef ref) => UserRepository();
