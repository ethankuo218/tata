import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Apple Sign In
  signInWithApple() async {}

  // Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return Future.error('User cancelled the login process');
    }

    try {
      // obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // create a new credential fro user
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // finally sign in
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'name': userCredential.user!.displayName,
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Phone Number Sign In
  signInWithPhoneNumber() async {}

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
