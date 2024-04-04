import 'package:cloud_firestore/cloud_firestore.dart';
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
}
