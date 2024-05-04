import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/ui/avatar.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

// Apple Sign In
  Future<Either<User, String>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      final UserCredential userCredential =
          await _firebaseAuth.signInWithProvider(appleProvider);

      DocumentReference<Map<String, dynamic>> doc =
          _fireStore.collection('users').doc(userCredential.user!.uid);

      if ((await doc.get()).data() == null) {
        await doc.set({
          'uid': userCredential.user!.uid,
          'name': null,
          'avatar': Avatar.getRandomAvatar().value
        }, SetOptions(merge: true));
      }

      return left(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

// Google Sign In
  Future<Either<User, String>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return right('User Cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      DocumentReference<Map<String, dynamic>> doc =
          _fireStore.collection('users').doc(userCredential.user!.uid);

      if ((await doc.get()).data() == null) {
        await doc.set({
          'uid': userCredential.user!.uid,
          'name': null,
          'avatar': Avatar.getRandomAvatar().value
        }, SetOptions(merge: true));
      }

      return left(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

// Phone Number Sign In
  Future<Either<String, String>> sendOtp(PhoneNumber phoneNumber) async {
    Completer<Either<String, String>> completer = Completer();

    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+${phoneNumber.countryCode}${phoneNumber.nsn}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await _firebaseAuth.signInWithCredential(credential);
          completer.complete(right("Auto-retrieval success: User signed in"));
        } catch (e) {
          completer.complete(left("Auto-retrieval failed: ${e.toString()}"));
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        completer.complete(left("Failed: ${e.code} - ${e.message}"));
      },
      codeSent: (String verificationId, int? resendToken) {
        completer.complete(right(verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Optionally handle timeout
      },
    );

    return completer.future;
  }

  Future<Either<User, String>> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      DocumentReference<Map<String, dynamic>> doc =
          _fireStore.collection('users').doc(userCredential.user!.uid);

      if ((await doc.get()).data() == null) {
        await doc.set({
          'uid': userCredential.user!.uid,
          'name': null,
          'avatar': Avatar.getRandomAvatar().value
        }, SetOptions(merge: true));
      }

      return left(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

  Future<Either<Unit, String>> resendOtp(PhoneNumber phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+${phoneNumber.countryCode}${phoneNumber.nsn}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          switch (e.code) {
            case 'invalid-phone-number':
              print('The provided phone number is not valid.');
              break;
            default:
              print('An error occurred while verifying the phone number.');
              break;
          }
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      return left(unit);
    } on FirebaseAuthException catch (e) {
      return right(e.message ?? 'Unknown Error');
    }
  }

// Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository();
