import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tata/src/core/avatar.dart';
import 'package:tata/src/models/app_user_info.dart';

class UserService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Get User Info
  Future<AppUserInfo> getUserInfo(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await _fireStore.collection('users').doc(uid).get();

    if (!user.exists) {
      throw Exception('User not found');
    }

    return AppUserInfo.fromMap(user.data()!);
  }

  // Get User Info List
  Future<List<AppUserInfo>> getUserInfoList(List<String> uidList) async {
    QuerySnapshot<Map<String, dynamic>> userList = await _fireStore
        .collection('users')
        .where('uid', whereIn: uidList)
        .get();

    return userList.docs.map((e) => AppUserInfo.fromMap(e.data())).toList();
  }

  // Edit User Info
  Future<void> editUserInfo(
      {required String uid, String? name, AvatarKey? avatar}) async {
    if (name == null && avatar == null) {
      throw Exception('Need to provide one of the value you want to edit');
    }

    await _fireStore.collection('users').doc(uid).update({
      ...name != null ? {'name': name} : {},
      ...avatar != null ? {'avatar': avatar} : {},
    });
  }
}
