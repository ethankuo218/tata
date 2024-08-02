import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/role.dart';
import 'package:tata/src/core/models/tarot_card.dart';

part 'reference_repository.g.dart';

class ReferenceRepository {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<TarotCard> getTarotCard(String number) async {
    return _firebaseFirestore
        .collection('tarot_cards')
        .doc(number)
        .get()
        .then((value) {
      return TarotCard.fromJson(value.data()!);
    });
  }

  Future<List<Role>> getRoleList() async {
    return _firebaseFirestore.collection('roles').get().then((value) {
      return value.docs.map((e) => Role.fromJson(e.data())).toList();
    });
  }

  Future<Role> getRole(String roleName) async {
    return _firebaseFirestore.collection('roles').get().then((roleList) {
      QueryDocumentSnapshot<Map<String, dynamic>> target =
          roleList.docs.filter((role) => role.data()['name'] == roleName).first;

      return Role.fromJson(target.data());
    });
  }
}

@Riverpod(keepAlive: true)
ReferenceRepository referenceRepository(ReferenceRepositoryRef ref) =>
    ReferenceRepository();
